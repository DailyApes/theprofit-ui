package engine.extended
{
	import mx.collections.IList;
	
	import spark.components.DropDownList;
	
	import engine.core.Core;
	
	public class DropDownList extends spark.components.DropDownList
	{
		[Bindable]
		public var translateColumns:String = '';
		
		private var _selectedColumn:String = '@item_id';
		private var _selectedValue:String = '';
		
		public function DropDownList()
		{
			super();
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
	}
}