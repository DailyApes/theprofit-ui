package engine.core
{
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.components.CheckBox;
	import spark.components.TextInput;
	
	import engine.managers.DataMobile;
	import engine.managers.TranslateMobile;

	public dynamic class CoreMobile
	{
		//colors
		[Bindable]
		public static var darkBlue:uint = 0x367dbe;
		[Bindable]
		public static var blue:uint = 0x76aad8;
		[Bindable]
		public static var lightBlue:uint = 0x8bb7de;
		[Bindable]
		public static var veryLightBlue:uint = 0xe1e9f0;
		
		[Bindable]
		public static var darkRed:uint = 0xc83925;
		[Bindable]
		public static var red:uint = 0xe37465;
		[Bindable]
		public static var lightRed:uint = 0xe78a7d;
		
		[Bindable]
		public static var darkOrange:uint = 0xcb7922;
		[Bindable]
		public static var orange:uint = 0xe39f56;
		[Bindable]
		public static var lightOrange:uint = 0xe7ad70;
		
		[Bindable]
		public static var darkGreen:uint = 0x6e9b5c;
		[Bindable]
		public static var green:uint = 0x8ab07a;
		[Bindable]
		public static var lightGreen:uint = 0x9bbc8e;
		
		[Bindable]
		public static var black:uint = 0x000000;
		[Bindable]
		public static var lightBlack:uint = 0x333333;
		
		[Bindable]
		public static var white:uint = 0xffffff;
		
		[Bindable]
		public static var veryDarkGray:uint = 0x696969;
		[Bindable]
		public static var darkGray:uint = 0x8a8a8a;
		[Bindable]
		public static var gray:uint = 0xc6c6c6;
		[Bindable]
		public static var lightGray:uint = 0xe8e8e8;
		[Bindable]
		public static var veryLightGray:uint = 0xf0f0f0;
		
		[Bindable]
		public static var overColor:uint;
		[Bindable]
		public static var downColor:uint;
		
		[Bindable]
		public static var size:Number = 1;
		
		[Bindable]
		public static var sizeMultiplier:Number = 24;
		
		public static var windowsСache:Array = new Array();
		public static var componentsСache:Array = new Array();
		
		[Bindable]
		public static var identified:Boolean;
		[Bindable]
		public static var authorized:Boolean;
		
		[Bindable]
		public static var translate:TranslateMobile;
		
		[Bindable]
		public static var application:Object;
		
		/*[Bindable]
		public static var launcher:Launcher;*/
		
		/*[Bindable]
		public static var infoTool:InfoTool;*/
		
		[Bindable]
		public static var windowsStackCount:Number = 0;
		
		[Bindable]
		public static var data:DataMobile;
		
		[Bindable]
		public static var requestTimeout:Number = 30;
		[Bindable]
		public static var serverUrl:String = '';
		
		[Bindable]
		public static var getHttpServiceModule:String = '';
		[Bindable]
		public static var setHttpServiceModule:String = '';
		
		[Bindable]
		public static var identificationView:Class;
		[Bindable]
		public static var mainView:Class;
		
		[Bindable]
		public static var accountData:Object;
		
		[Bindable]
		public static var sharedObject:SharedObject = SharedObject.getLocal('lt');
		
		[Bindable]
		public static var yii:Boolean = true;
		
		public static function init():void
		{
			overColor = lightBlue;
			downColor = darkBlue;
			
			application = FlexGlobals.topLevelApplication;
			
			data = application.data;
			translate = new TranslateMobile();
		}
		
		public static function getClass(object:*):Class
		{
			if (object)
			{
				return Class(getDefinitionByName(getQualifiedClassName(object)));
			}
			
			return Class;
		}
		
		public static function getSuperClass(object:*):Class
		{
			if (object)
			{
				return Class(getDefinitionByName(getQualifiedSuperclassName(object)));
			}
			
			return Class;
		}
		
		public static function getClassName(object:*):String
		{
			return getQualifiedClassName(object).split(':')[2];
		}
		
		public static function getSuperClassName(object:*):String
		{
			return getQualifiedSuperclassName(object).split(':')[2];
		}
		
		public static function callAfter(callFunction:Function, delay:Number = 1, argArray:Array = null):void
		{
			var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, callAfterTimer_timerHandler);
			timer.start();
			
			function callAfterTimer_timerHandler(event:TimerEvent):void
			{
				event.target.removeEventListener(TimerEvent.TIMER, callAfterTimer_timerHandler);
				callFunction.apply(null, argArray);
			}
		}
		
		public static function createComponent(componentClass:Class):*
		{
			var component:*;
			
			for (var i:int = 0; i < componentsСache.length; i++) 
			{
				if (!componentsСache[i].parent && getClassName(componentsСache[i]) == getClassName(componentClass))
				{
					return componentsСache[i];
				}
			}
			
			component = new componentClass();
			componentsСache.push(component);
			
			return component;
		}
		
		public static function clearAllComponents(target:Object):void
		{
			if (target.hasOwnProperty('numElements') && target.numElements)
			{
				for (var i:int = 0; i < target.numElements; i++) 
				{
					if (target.getElementAt(i) is TextInput)
					{
						target.getElementAt(i).text = '';
					}
					else if (target.getElementAt(i) is CheckBox)
					{
						target.getElementAt(i).selected = false;
					}
					else
					{
						clearAllComponents(target.getElementAt(i));
					}
					
					if (target.getElementAt(i).hasOwnProperty('errorString'))
					{
						target.getElementAt(i).errorString = '';
					}
				}
			}
		}
		
		public static function httpService_faultHandler(event:FaultEvent):void
		{
			
		}
		
		public static function getItem(object:Object, item:Object):Object
		{
			if (object)
			{
				return object[item];
			}
			return null;
		}
		
		public static function addZeros(value:Number, numOfSymbols:Number = 2):String
		{
			var string:String = String(value);
			var length:Number = string.length;
			
			if (length < numOfSymbols)
			{
				for (var i:int = 0; i < numOfSymbols - length; i++) 
				{
					string = '0' + string;
				}
			}
			return string;
		}
		
		public static function checkErrors(httpService:HTTPService):Boolean
		{
			if (!(httpService.lastResult is String) && httpService.lastResult.@error == 0)
			{
				return true;				
			}
			return false;
		}
		
		public static function getArraylength(value:Array):Number
		{
			return value.length;
		}
		
		public static function replaceAll(string:String, p:Object = null, repl:Object = null):String
		{
			if (Boolean(string))
			{
				while (string.match(p))
				{
					string = string.replace(p, repl);
				}				
			}
			
			return string;
		}
		
		public static function saveSharedObject():void
		{
			if (sharedObject)
			{
				sharedObject.flush();
				sharedObject = SharedObject.getLocal("lt");
			}
		}
		
		public static function toBoolean(value:Object):Boolean
		{
			if (value && Number(value) > 0)
			{
				return true;
			}
			
			return false;
		}
		
		public static function toNumber(value:*):Number
		{
			if (value && Number(value) > 0 && !isNaN(Number(value)))
			{
				return Number(value);
			}
			
			return 0;
		}
		
		public static function getObjectLength(object:Object):uint
		{
			var length:uint = 0;
			if (object)
			{
				for (var item:* in object)
				{
					if (item !== "mx_internal_uid" && object[item] !== null && object[item] !== undefined)
					{
						length++;
					}
				}
			}
			return length;
		}
		
		public static function arrayCollectionSort(arrayCollection:ArrayCollection, name:String, numeric:Boolean = false, descending:Boolean = false):ArrayCollection 
		{
			var dataSortField:SortField = new SortField();
			dataSortField.name = name;
			dataSortField.numeric = numeric;
			dataSortField.descending = descending;
			var numericDataSort:Sort = new Sort();
			numericDataSort.fields = [dataSortField];
			arrayCollection.sort = numericDataSort;
			arrayCollection.refresh();
			
			return arrayCollection;
		}
	}
}