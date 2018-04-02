package engine.core
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import mx.collections.ArrayCollection;
	import mx.collections.HierarchicalCollectionView;
	import mx.collections.XMLListCollection;
	import mx.controls.DateField;
	import mx.controls.Tree;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.core.FlexGlobals;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.events.IndexChangeEvent;
	import spark.events.TextOperationEvent;
	import spark.filters.ColorMatrixFilter;
	
	import engine.components.Window;
	import engine.elements.startwindow.StartWindow;
	import engine.extended.AdvancedDataGrid;
	import engine.extended.CheckBox;
	import engine.extended.ComboBox;
	import engine.extended.DropDownList;
	import engine.extended.NumericStepper;
	import engine.extended.TextArea;
	import engine.extended.TextInput;
	import engine.managers.Account;
	import engine.managers.Launcher;
	import engine.managers.Menus;
	import engine.managers.Translate;
	import engine.tools.LocalesTool;
	import engine.tools.infotool.InfoTool;
	
	public dynamic class Core
	{
		[Bindable]
		public static var version:String = '1.0.8';
		[Bindable]
		public static var build:String = '01.04.2018';
		[Bindable]
		public static var versionEnabled:Boolean = true;
		
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
		public static var veryDarkGreen:uint = 0x3d692d;
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
		public static var overColor:uint = 0x8bb7de;
		[Bindable]
		public static var downColor:uint = 0x367dbe;
		
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
		public static var translate:Translate;
		
		[Bindable]
		public static var account:Account = new Account();
		
		[Bindable]
		public static var application:Object;
		
		[Bindable]
		public static var launcher:Launcher;
		
		[Bindable]
		public static var infoTool:InfoTool;
		[Bindable]
		public static var localesTool:LocalesTool;
		
		[Bindable]
		public static var windowsStackCount:Number = 0;
		
		[Bindable]
		public static var previosSelectedWindow:Window;
		[Bindable]
		public static var selectedWindow:Window;
		
		[Bindable]
		public static var menus:Menus;
		[Bindable]
		public static var data:Object;
		
		[Bindable]
		public static var requestTimeout:Number = 30;
		[Bindable]
		public static var serverUrl:String = '';
		
		[Bindable]
		public static var yii:Boolean = true;
		
		[Bindable]
		public static var api:Object;
		
		[Bindable]
		public static var firstIdentification:Boolean = true;  
		
		[Bindable]
		public static var accountData:Object = new Object();
		
		private static var _apiType:String;
		
		[Bindable]
		public static var colorMatrixFilterBW:ColorMatrixFilter = new ColorMatrixFilter([0.2225, 0.7169, 0.0606, 0, 0,
			0.2225, 0.7169, 0.0606, 0, 0,
			0.2225, 0.7169, 0.0606, 0, 0,
			0, 0, 0, 1, 0
		]);
		
		[Bindable]
		public static var getHttpServiceModule:String = '';
		[Bindable]
		public static var setHttpServiceModule:String = '';
		
		[Bindable]
		public static var sharedObject:SharedObject = SharedObject.getLocal("lt");

		public static var sessionTimer:Timer = new Timer(60000);
		public static var refreshTimer:Timer = new Timer(100);
		
		[Bindable]
		public static var eventsXmlListCollection:XMLListCollection = new XMLListCollection();
		
		[Bindable]
		public static var sessionHttpService:HTTPService = new HTTPService();
		
		public static function init():void
		{
			overColor = lightBlue;
			downColor = darkBlue;
			
			application = FlexGlobals.topLevelApplication;
			
			launcher = application.launcher;
			menus = application.menus;
			
			data = application.data;
			translate = new Translate();
			
			infoTool = new InfoTool();
			
			
			localesTool = new LocalesTool();
			
			/*if (!api)
			{
				callAfterCreation(Core.data.locales, 'dataProvider', Core.launcher.launch, ['IdentificationWindow']);
			}
			else
			{
				callAfterCreation(Core.data.locales, 'dataProvider', Core.launcher.launch, ['BasicApiIdentificationWindow']);
			}*/
			
			application.callLater(function():void
			{
				application.stage.showDefaultContextMenu = false;
			});
			
			sessionHttpService.addEventListener(ResultEvent.RESULT, sessionHttpService_resultHandler);
			sessionTimer.addEventListener(TimerEvent.TIMER, sessionTimer_timerHandler);
			
			refreshTimer.addEventListener(TimerEvent.TIMER, refreshTimer_timerHandler);
			refreshTimer.start();
			
			localesTool.init();
		}
		
		public static function initialize():void
		{
			menus.init();
			infoTool.init();
			
			
			callAfterCreation(Core.data.locales, 'dataProvider', Core.launcher.launch, ['IdentificationWindow']);
		}
		
		private static function sessionTimer_timerHandler(event:TimerEvent):void
		{
			sessionHttpService.url = serverUrl + (yii ? '/?r=' : '/') + getHttpServiceModule + '/session';
			sessionHttpService.resultFormat = 'e4x';
			sessionHttpService.send();
		}
		
		private static function refreshTimer_timerHandler(event:TimerEvent):void
		{
			application.viewport.spikeButton.dispatchEvent(new MouseEvent('mouseOver'));
			application.viewport.spikeButton.dispatchEvent(new MouseEvent('mouseOut'));
		}
		
		private static function sessionHttpService_resultHandler(event:ResultEvent):void
		{
			checkErrors(sessionHttpService);
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
		
		public static function addWindow(window:Window, data:Object = null, parentWindow:Window = null):Window
		{
			window.data = data;
			window.parentWindow = parentWindow;
			
			if (!window.maximized)
			{
				if (window.centered)
				{
					window.horizontalCenter = Math.round((window.windowsStackEnabled ? (windowsStackCount * Core.size * Core.sizeMultiplier * 2 + 4) : 0) + (window.parentWindow ? window.parentWindow.x - (application.width / 2 - window.parentWindow.width / 2) : 0));
					window.verticalCenter = Math.round((window.windowsStackEnabled ? (windowsStackCount * Core.size * Core.sizeMultiplier + 4) : 0) + (window.parentWindow ? window.parentWindow.y - (application.height / 2 - window.parentWindow.height / 2) : 0));
				}
				else
				{
					window.x = Math.round(window.windowsStackEnabled ? application.viewport.width / 2 - window.width / 2 + (windowsStackCount * Core.size * Core.sizeMultiplier * 2 + 4) : application.viewport.width / 2 - window.width / 2);
					window.y = Math.round(window.windowsStackEnabled ? application.viewport.height / 2 - window.height / 2 + (windowsStackCount * Core.size * Core.sizeMultiplier + 4) : application.viewport.height / 2 - window.height / 2);
					
					window.backupX = window.x;
					window.backupY = window.y;
				}
				
				if (window.windowsStackEnabled)
				{
					window.windowsStackCount = windowsStackCount;
					windowsStackCount++;
					if (windowsStackCount > 3)
					{
						windowsStackCount = 0;
					}
				}
			}
			
			if (window.isPopupWindow)
			{
				window = application.viewport.popUpWindowsGroup.addElement(window) as Window;
			}
			else
			{
				window = application.viewport.windowsGroup.addElement(window) as Window;
				
				if (application.viewport.maximized && window.maximizable)
				{
					callAfter(function():void
					{
						window.maximized = true;
					});
				}
			}
			
			application.viewport.refresh();
			
			return window;
		}
		
		public static function removeWindow(window:Window):Window
		{
			if (window && window.parent)
			{
				if (!window.isPopUp)
				{
					window.parent['removeElement'](window);
					selectWindow(window.parentWindow);
				}
				else
				{
					PopUpManager.removePopUp(window);
				}
				
				window.disable();
				
				application.viewport.refresh();
				
				application.viewport.regroup();
				
				//windowsStackCount = 0;
			}
			
			return window;
		}
		
		public static function removeAllWindows():void
		{
			windowsStackCount = 0;
			for (var i:int = 0; i < windowsСache.length; i++) 
			{
				if (windowsСache[i].parent)
				{
					removeWindow(windowsСache[i]);
				}
			}
		}
		
		public static function selectWindow(window:* = null):Window
		{
			if (window)
			{
				for (var i:int = 0; i < windowsСache.length; i++) 
				{
					if (windowsСache[i].parent && windowsСache[i] !== window)
					{
						windowsСache[i].selected = false;
					}
				}
				
				if (window is Class)
				{
					var windowsArray:Array = findWindows(window);
					if (windowsArray.length > 0)
					{
						return selectWindow(windowsArray[windowsArray.length - 1]);
					}
					else
					{
						return null;
					}
				}
				else
				{
					window.selected = true;
					previosSelectedWindow = selectedWindow;
					selectedWindow = window;					
				}
				
				return window;
			}
			else if (previosSelectedWindow && previosSelectedWindow.parent && previosSelectedWindow.fronted)
			{
				previosSelectedWindow.selected = true;
				selectedWindow = previosSelectedWindow;
				
				return window;
			}
			else
			{
				windowsArray = findFrontedWindows();
				if (windowsArray.length > 0)
				{
					windowsArray[windowsArray.length - 1].selected = true;
					previosSelectedWindow = selectedWindow;
					selectedWindow = windowsArray[windowsArray.length - 1];
					
					return window;
				}
				else
				{
					previosSelectedWindow = selectedWindow;
					selectedWindow = null;
				}
			}
			
			return null;
		}
		
		public static function findWindow(windowClass:Class = null):Window
		{
			for (var i:int = 0; i < windowsСache.length; i++) 
			{
				if (windowsСache[i].parent && (getClassName(windowsСache[i]) == getClassName(windowClass) || windowClass == null))
				{
					return windowsСache[i];
				}
			}
			
			return null;
		}
		
		public static function findWindows(windowClass:Class = null):Array
		{
			var windowsArray:Array = new Array();
			
			for (var i:int = 0; i < windowsСache.length; i++) 
			{
				if (windowsСache[i].parent && (getClassName(windowsСache[i]) == getClassName(windowClass) || windowClass == null))
				{
					windowsArray.push(windowsСache[i]);
				}
			}
			
			return windowsArray;
		}
		
		public static function findFrontedWindows(windowClass:Class = null):Array
		{
			var windowsArray:Array = new Array();
			
			for (var i:int = 0; i < windowsСache.length; i++) 
			{
				if (windowsСache[i].parent && (getClassName(windowsСache[i]) == getClassName(windowClass) || windowClass == null) && windowsСache[i].fronted)
				{
					windowsArray.push(windowsСache[i]);
				}
			}
			
			return windowsArray;
		}
		
		public static function findFrontedResizableWindows(windowClass:Class = null):Array
		{
			var windowsSourceArray:Array = findFrontedWindows(windowClass);
			var windowsArray:Array = new Array();
			
			for (var i:int = 0; i < windowsSourceArray.length; i++) 
			{
				if (windowsSourceArray[i].resizable || windowsSourceArray[i].maximizable)
				{
					windowsArray.push(windowsSourceArray[i]);
				}
			}
			
			return windowsArray;
		}
		
		public static function findFrontedMaximizableWindows(windowClass:Class = null):Array
		{
			var windowsSourceArray:Array = findFrontedWindows(windowClass);
			var windowsArray:Array = new Array();
			
			for (var i:int = 0; i < windowsSourceArray.length; i++) 
			{
				if (windowsSourceArray[i].maximizable)
				{
					windowsArray.push(windowsSourceArray[i]);
				}
			}
			
			return windowsArray;
		}
		
		public static function findDockedWindows(windowClass:Class = null):Array
		{
			var windowsArray:Array = new Array();
			
			for (var i:int = 0; i < Core.componentsСache.length; i++) 
			{
				if (Core.componentsСache[i].parent && (getClassName(Core.componentsСache[i].targetWindow) == getClassName(windowClass) || windowClass == null))
				{
					windowsArray.push(Core.componentsСache[i].targetWindow);
				}
			}
			
			return windowsArray;
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
		
		public static function createWindow(windowClass:Class):Window
		{
			var window:Window;
			
			for (var i:int = 0; i < windowsСache.length; i++) 
			{
				if (!windowsСache[i].parent && getClassName(windowsСache[i]) == getClassName(windowClass))
				{
					var item:Window = windowsСache.splice(i, 1)[0];
					windowsСache.push(item);
					return item;
				}
			}
			
			window = new windowClass();
			windowsСache.push(window);
			
			return window;
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
			if (target.hasOwnProperty('numElements'))
			{
				for (var i:int = 0; i < target.numElements; i++) 
				{
					if (target.getElementAt(i) is TextInput)
					{
						target.getElementAt(i).text = '';
					}
					else if (target.getElementAt(i) is TextArea)
					{
						target.getElementAt(i).text = '';
					}
					else if (target.getElementAt(i) is CheckBox)
					{
						target.getElementAt(i).selected = false;
					}
					else if (target.getElementAt(i) is NumericStepper)
					{
						target.getElementAt(i).value = 0;
					}
					else if (target.getElementAt(i) is DateField)
					{
						target.getElementAt(i).text = '';
					}
					else if (target.getElementAt(i) is ComboBox)
					{
						target.getElementAt(i).selectedIndex = -1;
					}
					else if (target.getElementAt(i) is DropDownList)
					{
						target.getElementAt(i).selectedIndex = -0;
					}
					else if (Core.getClassName(target.getElementAt(i)) !== 'Autoreloader')
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
		
		public static function myStyleFunc(data:Object, col:AdvancedDataGridColumn):Object
		{
			// all rows for invalid selection combinations
			if ((data["isRequired"]) && !(data["isSelected"]))
				return {color:0xFF0000, fontWeight:"bold", backgroundColor:0xf2d6d7}; 
			
			// Return null if the selection is valid
			return null;
		}
		
		public static function tree_itemClickHandler(event:ListEvent):void {
			var item:Object = Tree(event.currentTarget).selectedItem;
			if (event.currentTarget.dataDescriptor.isBranch(item))
			{
				event.currentTarget.expandItem(item, !event.currentTarget.isItemOpen(item), true);
			}
		}
		
		public static function httpService_faultHandler(event:FaultEvent):void
		{
			if (translate)
			{
				addEvent(event.target.url, translate.to(['error_code_n']), true, '', true);
			}
		}
		
		public static function getItem(object:Object, item:Object):Object
		{
			if (object && !(object is String))
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
		
		public static function checkErrors(httpService:HTTPService, action:String = 'system', checkForOnline:Boolean = true, show:Boolean = true):Object
		{
			if (!httpService.lastResult)
			{
				addEvent(action, translate.to(['error_code_3']), show, '', true);
				return null;
			}
			else if (!(httpService.lastResult is String) && httpService.lastResult.@error == 0)
			{
				if (checkForOnline && httpService.lastResult.@online == 0)
				{
					Core.findWindow(StartWindow).setHttpService.send();
				}
				
				return 0;				
			}
			else if (httpService.lastResult is String)
			{
				addEvent(action, translate.to(['error_code_n']), show, '', true);
			}
			else
			{
				var array:Array = String(httpService.lastResult.@error).split(',');
				
				for (var i:int = 0; i < array.length; i++) 
				{
					addEvent(action, translate.to(['error_code_' + array[i]]), show, '', true);
				}
			}
			return httpService.lastResult.@error;
		}
		
		public static function getArraylength(value:Array):Number
		{
			return value.length;
		}
		
		public static function replaceAll(string:String, p:Object = null, repl:Object = null):String
		{
			if (String(string).length > 0)
			{
				while (string.match(p))
				{
					string = string.replace(string.match(p), repl);
				}				
			}
			
			return string;
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
		
		public static function selectItem(target:Object, column:String = '', value:String = '', dispatchEvent:Boolean = false):Object
		{
			if (target && target.dataProvider && column && column.length > 0 && value && value.length > 0)
			{
				if (target.dataProvider is HierarchicalCollectionView)
				{
				}
				else
				{
					for (var i:int = 0; i < target.dataProvider.length; i++) 
					{
						if (String(target.dataProvider[i][column]) == String(value))
						{
							target.selectedIndex = i;
							
							if (dispatchEvent)
							{
								if (target is DropDownList || target is ComboBox)
								{
									target.dispatchEvent(new IndexChangeEvent('change'));
								}
								else if (target is AdvancedDataGrid)
								{
									target.dispatchEvent(new ListEvent('change'));
								}
							}
							return target.dataProvider[i][column];
						}
					}					
				}
			}
			
			return null;
		}
		
		public static function saveSharedObject():void
		{
			if (sharedObject)
			{
				sharedObject.flush();
				sharedObject = SharedObject.getLocal("lt");
			}
		}
		
		public static function addEvent(message:String, description:String = '', show:Boolean = false, action:String = '', error:Boolean = false):void
		{
			var time:String = Core.addZeros(new Date().hours) + ':' + Core.addZeros(new Date().minutes) + ':' + Core.addZeros(new Date().seconds);
			var timeNumeric:Number = new Date().time;
			eventsXmlListCollection.addItem(XML('<item time_numeric="' + timeNumeric + '" time="' + time + '" message="' + message + (description.length > 0 ? (' > ' + description) : '') + '" action="' + action + '" error="' + Number(error) + '"/>'));
			
			if (show)
			{
				infoTool.show();
			}
			
			infoTool.refresh();
		}
		
		public static function clearAllEvents():void
		{
			eventsXmlListCollection.source = null;
		}
		
		public static function checkUnique(dataProvider:Object, column:String, value:String, excludeRowIndex:Number = -1):Boolean
		{
			for (var i:int = 0; i < dataProvider.length(); i++) 
			{
				if (dataProvider[i][column].toString() == value && i !== excludeRowIndex)
				{
					return false;
				}
			}
			
			return true;
		}
		
		public static function dispatchAllComponents(target:Object):void
		{
			if (target.hasOwnProperty('numElements'))
			{
				for (var i:int = 0; i < target.numElements; i++)
				{
					if (target.getElementAt(i) is TextInput)
					{
						target.getElementAt(i).dispatchEvent(new TextOperationEvent('change'));
					}
					else if (target.getElementAt(i) is TextArea)
					{
						target.getElementAt(i).dispatchEvent(new TextOperationEvent('change'));
					}
					else if (target.getElementAt(i) is CheckBox)
					{
						target.getElementAt(i).dispatchEvent(new Event('change'));
					}
					else if (target.getElementAt(i) is NumericStepper)
					{
						target.getElementAt(i).dispatchEvent(new Event('change'));
					}
					else if (target.getElementAt(i) is DateField)
					{
						target.getElementAt(i).dispatchEvent(new CalendarLayoutChangeEvent('change'));
					}
					else if (target.getElementAt(i) is ComboBox)
					{
						target.getElementAt(i).dispatchEvent(new IndexChangeEvent('change'));
					}
					else if (target.getElementAt(i) is DropDownList)
					{
						target.getElementAt(i).dispatchEvent(new IndexChangeEvent('change'));
					}
					else if (Core.getClassName(target.getElementAt(i)) !== 'Autoreloader')
					{
						dispatchAllComponents(target.getElementAt(i));
					}
				}
			}
		}
		
		public static function callAfterCreation(target:Object, ownProperty:String, callFunction:Function, callFunctionParams:Array = null, delay:Number = 100):void
		{
			Core.callAfter(function():void
			{
				if (!target.hasOwnProperty(ownProperty))
				{
					callAfter(callAfterCreation, delay, [target, ownProperty, callFunction, callFunctionParams]);
				}
				else
				{
					callFunction.apply(null, callFunctionParams);
				}
			}, delay);
		}
		
		public static function getItemValue(dataProvider:Object, column:String, value:String, returnColumn:String):Object
		{
			if (dataProvider)
			{
				for (var i:int = 0; i < dataProvider.length(); i++) 
				{
					if (String(dataProvider[i][column]) == value)
					{
						return dataProvider[i][returnColumn];
					}
				}
			}
			
			return null;
		}
		
		public static function toArrayList(value:XMLList, translateColumns:String = '', sortFields:Array = null):ArrayCollection
		{
			var arrayCollection:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < value.length(); i++)
			{
				if (!Core.toBoolean(value[i]['@archived']))
				{
					var item:Object = new Object();
					
					if (value[i].children().length() > 0)
					{
						item['children'] = toArrayList(value[i].children());
					}
					
					for (var j:int = 0; j < value[i].attributes().length(); j++) 
					{
						item['@' + String(value[i].attributes()[j].name())] = value[i].attributes()[j];
					}
					
					arrayCollection.addItem(item);
				}
			}
			
			if (translateColumns.length > 0)
			{
				Core.translate.columns(arrayCollection, translateColumns);
			}
			
			if (sortFields)
			{
				if (!arrayCollection.sort)
				{
					arrayCollection.sort = new Sort();
				}
				
				arrayCollection.sort.fields = sortFields;
				arrayCollection.refresh();
			}
			
			return arrayCollection;
		}
		
		public static function getItemMaxValue(dataProvider:Object, column:String):Number
		{
			var maxValue:Number = 0;
			
			if (dataProvider) 
			{
				for (var i:int = 0; i < dataProvider.length(); i++) 
				{
					if (dataProvider[i][column] > maxValue)
					{
						maxValue = dataProvider[i][column];
					}
				}
			}
			
			return maxValue;
		}
		
		public static function getItemOnMaxValue(dataProvider:Object, column:String):Object
		{
			var maxValue:Number = 0;
			var item:Object;
			
			if (dataProvider) 
			{
				for (var i:int = 0; i < dataProvider.length(); i++) 
				{
					if (dataProvider[i][column] > maxValue)
					{
						maxValue = dataProvider[i][column];
						item = dataProvider[i];
					}
				}
			}
			
			return item;
		}
		
		public static function getItemIndexOnMaxValue(dataProvider:Object, column:String):Number
		{
			var maxValue:Number = 0;
			var index:Number = -1;
			
			if (dataProvider) 
			{
				for (var i:int = 0; i < dataProvider.length(); i++) 
				{
					if (dataProvider[i][column] > maxValue)
					{
						maxValue = dataProvider[i][column];
						index = i;
					}
				}
			}
			
			return index;
		}
		
		public static function swapItems(array:Array, item1:Object, item2:Object):void
		{
			var item1pos:int = array.indexOf(item1);
			var item2pos:int = array.indexOf(item2);
			
			if ((item1pos != -1) && (item2pos != -1))
			{
				var tempItem:Object = array[item2pos];
				array[item2pos] = array[item1pos];
				array[item1pos] = tempItem;
			}
		}
		
		public static function hideUndefined(value:*, defaultValue:String = ''):String
		{
			if (!value || value == undefined || value == 'undefined')
			{
				return defaultValue;
			}
			
			return value.toString();
		}
		
		public static function sumDataProviderColumnWhere(dataProvider:Object, column:String, whereColumn:String, expression:String, whereValue:String):Number
		{
			var value:Number = 0;
			var length:Number = dataProvider is XMLList || dataProvider is XML? dataProvider.length() : dataProvider.length;
			
			if (dataProvider)
			{
				for (var i:int = 0; i < length; i++)
				{
					switch(expression)
					{
						case '=':
						{
							if (dataProvider[i][whereColumn] == whereValue)
							{
								value += Core.toNumber(dataProvider[i][column]);
							}
							break;
						}
							
						default:
						{
							break;
						}
					}
				}
			}
			
			return value;
		}
		
		public static function sumDataProviderColumn(dataProvider:Object, column:String):Number
		{
			var value:Number = 0;
			var length:Number = dataProvider is XMLList || dataProvider is XML? dataProvider.length() : dataProvider.length;
			
			if (dataProvider)
			{
				for (var i:int = 0; i < length; i++)
				{
					value += Core.toNumber(dataProvider[i][column]);
				}
			}
			
			return value;
		}
		
		public function arrayCollectionSort(arrayCollection:ArrayCollection, name:String, numeric:Boolean = false, descending:Boolean = false):ArrayCollection 
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
		
		public static function fixDataProvider(value:Object):ArrayCollection
		{
			var arrayCollection:ArrayCollection = new ArrayCollection();
			if (value)
			{
				if ((value.length as Number < 2 || !value.length as Number) && !(value is ArrayCollection))
				{
					arrayCollection.addItemAt(value, 0);
				}
				else
				{
					arrayCollection = value as ArrayCollection;
				}
			}
			
			return arrayCollection;
		}
		
		public static function traceObjectItems(object:Object):void
		{
			if (object)
			{
				for (var i:Object in object) 
				{
					trace(i, object[i]);
				}				
			}
		}
		
		public static function getArrayItemIndex(array:Array, item:Object):Number
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] == item)
				{
					return i;
				}
			}
			
			return -1;
		}
		
		public static function dateConvert(date:Date):String
		{
			if (!date)
			{
				date = new Date(0, 0, 0, 0, 0, 0, 0);
			}
			
			return date.fullYear + '-' + Core.addZeros(date.month + 1) + '-' + Core.addZeros(date.date) + ' ' + Core.addZeros(date.hours) + ':' + Core.addZeros(date.minutes) + ':' + Core.addZeros(date.seconds);
		}
		
		public static function dateFromString(string:String):Date
		{
			var dateArray:Array = string.split(' ')[0].split('-');
			var timeArray:Array = string.split(' ')[1].split(':');
			
			return new Date(dateArray[0], dateArray[1] - 1, dateArray[2], timeArray[0], timeArray[1], timeArray[2]);
		}
		
		public static function today():Date
		{
			var date:Date = new Date();
			
			return new Date(date.fullYear, date.month, date.date);
		}
		
		public static function inList(value:Object, array:Array):Boolean
		{
			if (array)
			{
				for (var i:int = 0; i < array.length; i++) 
				{
					if (String(array[i]) == String(value))
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		[Bindable]
		public static function set apiType(value:String):void
		{
			_apiType = value;
		}
		
		public static function get apiType():String
		{
			return _apiType;
		}
		
		public static function replaceVariables(string:String):String
		{
			var returnString:String = Core.replaceAll(string, '_server_url_', serverUrl);
			
			return returnString;
		}
		
		public static function toArrayFromString(string:String):Array
		{
			var array:Array = new Array();
			
			if (string && string.indexOf(',') !== -1)
			{
				array = Core.replaceAll(string, ' ', '').split(',');
			}
			
			return array;
		}
	}
}