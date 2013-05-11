package org.ushan.marbles.models
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	import org.ushan.core.mvc.interfaces.IModel;
	import org.ushan.marbles.models.configs.Config;
	import org.ushan.marbles.models.configs.EConfigConstants;
	
	
	public class Space extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//	read only 
		//----------------------------------------------------------------------
		public function get world()		:b2World { return _world;}
		private var _world				:b2World;
		
		public function get mouseJoint():b2MouseJoint { return _mouseJoint;}
		private var _mouseJoint			:b2MouseJoint;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		
		private var model			:Model;
		private var scale			:Number;
		private var box2dDebuger	:b2DebugDraw;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function Space()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		public function setDebuger(initiator:IModel, debuger:Sprite):void
		{
			var sh:Shape = new Shape();
			sh.graphics.beginFill(0xff0000);
			sh.graphics.drawCircle(200, 200, 10);
			debuger.addChild(sh);
			box2dDebuger = new b2DebugDraw();
			
			box2dDebuger.m_sprite = debuger;
			box2dDebuger.m_drawScale = 30.0;
			box2dDebuger.m_fillAlpha = 0.3;
			box2dDebuger.m_lineThickness = 1.0;
			box2dDebuger.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
			_world.SetDebugDraw(box2dDebuger);
		}
		
		internal function attachMouseToBall(initiator:ModelBall,
											point:Point,
											body:b2Body):void
		{
			if (_mouseJoint)
			{
				_world.DestroyJoint(_mouseJoint);
			}
			var md:b2MouseJointDef = new b2MouseJointDef();
			md.body1 = _world.m_groundBody;
			md.body2 = body;
			md.target.Set(point.x / scale, point.y / scale);
			md.maxForce = 1000.0 * body.m_mass;
			md.timeStep = EConfigConstants.PH_TIME_STEP;
			_mouseJoint = _world.CreateJoint(md) as b2MouseJoint;
			body.WakeUp();
		}
		
		internal function destroyJoint(initiator:ModelBall):void
		{
			_world.DestroyJoint(_mouseJoint);
			_mouseJoint = null;
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			initVars();
			initEnvironment();
			initGround();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initVars():void
		{
			scale = EConfigConstants.PH_SCALE;
		}
		
		private function initEnvironment():void
		{
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-1000.0, -1000.0);
			worldAABB.upperBound.Set(1000.0, 1000.0);
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, EConfigConstants.PH_GRAVITY);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			_world = new b2World (worldAABB, gravity, doSleep);
		}
		
		private function initGround():void
		{
/*			var wallSd:b2PolygonDef = new b2PolygonDef();
			var wallBd:b2BodyDef = new b2BodyDef();
			var wall:b2Body;*/
			
			var scale:Number = EConfigConstants.PH_SCALE;
			
			var wWidth:Number = model.config.sceneWidth;
			var wHeight:Number = model.config.sceneHeight;
			var depth:Number = 100;
			var margin:Number = 30;
			
			
			
			// Create border of boxes
			var wallSd:b2PolygonDef = new b2PolygonDef();
			var wallBd:b2BodyDef = new b2BodyDef();
			var wallB:b2Body;
			
			// Left
			wallBd.position.Set(- depth / scale, wHeight / scale / 2);
			wallSd.SetAsBox(depth / scale, (wHeight + depth) / scale / 2);
			wallB = _world.CreateStaticBody(wallBd);
			wallB.CreateShape(wallSd);
			wallB.SetMassFromShapes();
			// Right
			wallBd.position.Set((wWidth + depth) / scale, wHeight/scale/2);
			wallB = _world.CreateStaticBody(wallBd);
			wallB.CreateShape(wallSd);
			wallB.SetMassFromShapes();
			// Top
			wallBd.position.Set((wWidth -  margin) / scale / 2, - depth / scale);
			wallSd.SetAsBox((wWidth +  depth) / scale / 2, depth / scale);
			wallB = _world.CreateStaticBody(wallBd);
			wallB.CreateShape(wallSd);
			wallB.SetMassFromShapes();
			// Bottom
			wallBd.position.Set(wWidth /scale / 2, (wHeight + depth) / scale);
			wallB = _world.CreateStaticBody(wallBd);
			wallB.CreateShape(wallSd);
			wallB.SetMassFromShapes();
			
			
			wallBd.position.Set(180 / scale, 180 / scale);
			wallSd.SetAsBox(80 / scale, 30 / scale);
			wallB = _world.CreateStaticBody(wallBd);
			wallB.CreateShape(wallSd);
			wallB.SetMassFromShapes();
		}
	}
}