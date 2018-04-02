package engine.extended
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	
	import spark.components.ComboBox;
	import spark.events.IndexChangeEvent;
	import spark.events.TextOperationEvent;
	
	import engine.core.Core;
	import engine.skins.ComboBoxSkin;
	
	public class ComboBox extends spark.components.ComboBox
	{
		[Bindable]
		public var translateColumns:String = '';
		
		private var _selectedColumn:String = '@item_id';
		private var _selectedValue:String = '';
		
		//private var _widthInChars:Number = 12;
		
		[Bindable]
		public var defaultSelectedIndex:Number = -1;
		
		public function ComboBox()
		{
			super();
			addEventListener(Event.CHANGE, changeHandler);
			setStyle('skinClass', ComboBoxSkin);
		}
		
		private function changeHandler(event:Event):void
		{
			errorString = '';
		}
		
		override protected function textInput_changeHandler(event:TextOperationEvent):void
		{
			super.textInput_changeHandler(event);
			
			if (textInput.text == '' && defaultSelectedIndex !== -1)
			{
				selectedIndex = defaultSelectedIndex;
				dispatchEvent(new IndexChangeEvent('change'));
			}
		}
		
		[Bindable]
		public function set selectedColumn(value:String):void
		{
			_selectedColumn = value;
			
			callLater(Core.selectItem, [this, selectedColumn, selectedValue]);
		}
		
		public function get selectedColumn():String
		{
			return _selectedColumn;
		}
		
		[Bindable]
		public function set widthInChars(value:Number):void
		{
			callLater(function():void
			{
				textInput.widthInChars = value;				
			});
		}
		
		public function get widthInChars():Number
		{
			return textInput ? textInput.widthInChars : 0;
		}
		
		[Bindable]
		public function set selectedValue(value:String):void
		{
			_selectedValue = value;
			
			callLater(Core.selectItem, [this, selectedColumn, selectedValue]);
		}
		
		public function get selectedValue():String
		{
			return _selectedValue;
		}
		
		[Bindable]
		override public function set dataProvider(value:IList):void
		{
			super.dataProvider = value;
			
			Core.translate.columns(dataProvider, translateColumns);
			
			callLater(Core.selectItem, [this, selectedColumn, selectedValue]);
		}
		
		override public function set errorString(value:String):void
		{
			super.errorString = value;
			
			if (value && value.length > 0)
			{
				callLater(function():void
				{
					dispatchEvent(new MouseEvent("mouseOut"));
					dispatchEvent(new MouseEvent("mouseOver"));
				});
			}
		}
	}
}