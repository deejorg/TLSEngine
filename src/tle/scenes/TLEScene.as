package tle.scenes
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import tle.cameras.TLECamera;
	import tle.display.TLESprite;
	import tle.entities.TLEEntity;
	import tle.TLEDirector;
	
	public class TLEScene extends TLESprite
	{
		public function TLEScene()
		{
			_entities = new Dictionary();
			_collisionsListeners = new Vector.<CollisionListener>();
			
			camera = new TLECamera(TLEDirector.instance.resolution.x, TLEDirector.instance.resolution.y);
			
			_gameLayer = new TLESprite();
			addChild(_gameLayer);
			
			_guiLayer = new TLESprite();
			addChild(_guiLayer);
			
			setup();
		}
		
		//lifecycle (virtual functions)
		protected function setup():void
		{
		}
		
		public function update():void
		{
		
		}
		
		//entities
		protected var _entities:Dictionary;
		
		public function getAllEntities():Vector.<TLEEntity>
		{
			var entities:Vector.<TLEEntity> = new Vector.<TLEEntity>();
			
			for each (var entityType:Vector.<TLEEntity>in _entities)
			{
				entities = entities.concat(entityType);
			}
			
			return entities;
		}
		
		public function getEntitiesByType(type:String):Vector.<TLEEntity>
		{
			return _entities[type];
		}
		
		public function addEntity(entity:TLEEntity):void
		{
			//get entity type
			var type:String = entity.type;
			
			if (type == null)
				type = getQualifiedClassName(entity);
			
			//get entity type vector
			var entities:Vector.<TLEEntity> = _entities[type];
			
			if (entities)
			{
				//check if entity already exists at its type
				if (entities.indexOf(entity) != -1)
					return;
			}
			else
			{
				//if don't exist create a new one and add to _entities
				entities = new Vector.<TLEEntity>();
				_entities[type] = entities;
			}
			
			//add entity to type vector
			_entities[type].push(entity);
			
			//sets entity scene
			entity.scene = this;
			
			//add entity view to layer
			if (!entity.layer)
				entity.layer = _gameLayer;
		}
		
		public function removeEntity(entity:TLEEntity):void
		{
			//get entity type
			var type:String = entity.type;
			
			if (type == null)
				type = getQualifiedClassName(entity);
			
			//get entity type vector
			var entities:Vector.<TLEEntity> = _entities[type];
			
			if (!entities)
				return;
			
			//get entity index
			var entityIndex:int = entities.indexOf(entity)
			
			if (entities.indexOf(entity) == -1)
				return;
			
			//remove entity of type vector
			_entities[type].splice(entityIndex, 1);
			
			//sets entity scene as null
			entity.scene = null;
			
			//remove entity view from layer
			entity.layer = null;
		}
		
		//update entities
		public function updateEntities():void
		{
			for each (var entity:TLEEntity in getAllEntities())
			{
				entity.update();
			}
		}
		
		//render entities
		public function renderEntities():void
		{
			for each (var entity:TLEEntity in getAllEntities())
			{
				entity.render();
			}
		}
		
		//camera
		protected var _camera:TLECamera;
		
		public function get camera():TLECamera
		{
			return _camera;
		}
		
		public function set camera(value:TLECamera):void
		{
			if (_camera)
				_camera.scene = null;
			
			_camera = value;
			
			camera.scene = this;
		}
		
		//game layer
		protected var _gameLayer:TLESprite;
		
		public function get gameLayer():TLESprite
		{
			return _gameLayer;
		}
		
		//gui layer
		protected var _guiLayer:TLESprite;
		
		public function get guiLayer():TLESprite
		{
			return _guiLayer;
		}
		
		//hitbox collisions
		protected var _collisionsListeners:Vector.<CollisionListener>;
		
		public final function checkCollisions():void
		{
			var entitiesType1:Vector.<TLEEntity>;
			var entitiesType2:Vector.<TLEEntity>;
			
			for each (var collisionListener:CollisionListener in _collisionsListeners)
			{
				entitiesType1 = getEntitiesByType(collisionListener.type1);
				entitiesType2 = getEntitiesByType(collisionListener.type2);
				
				for each (var entityType1:TLEEntity in entitiesType1)
				{
					for each (var entityType2:TLEEntity in entitiesType2)
					{
						if (entityType1.hitBox.collide(entityType2.hitBox))
						{
							collisionListener.listener.call(entityType1, entityType2);
						}
					}
				}
			}
		}
		
		public function addCollisionListener(type1:String, type2:String, listener:Function):void
		{
			//checks if collision listener already exists
			for each (var collisionListener:CollisionListener in _collisionsListeners)
			{
				if (collisionListener.listener == listener)
				{
					if ((collisionListener.type1 == type1 && collisionListener.type2 == type2) || (collisionListener.type2 == type1 && collisionListener.type1 == type2))
					{
						return;
					}
				}
			}
			
			//creates collision listener
			_collisionsListeners.push(new CollisionListener(type1, type2, listener));
		}
		
		public function removeCollisionListener(type1:String, type2:String, listener:Function):void
		{
			var collisionListener:CollisionListener;
			
			for (var i:uint = 0; i < _collisionsListeners.length; i++)
			{
				collisionListener = _collisionsListeners[i] as CollisionListener;
				
				//checks if it exists
				if (collisionListener.listener == listener)
				{
					if ((collisionListener.type1 == type1 && collisionListener.type2 == type2) || (collisionListener.type2 == type1 && collisionListener.type1 == type2))
					{
						//removes it if exists
						_collisionsListeners.splice(i, 1);
					}
				}
			}
		}
	}
}

class CollisionListener
{
	public var type1:String;
	public var type2:String;
	public var listener:Function;
	
	public function CollisionListener(type1:String = null, type2:String = null, listener:Function = null)
	{
		this.type1 = type1;
		this.type2 = type2;
		this.listener = listener;
	}
}