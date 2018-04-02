package engine.extended
{
	import mx.collections.IList;
	
	import spark.components.List;
	
	import engine.core.Core;
	
	public class List extends spark.components.List
	{
		[Bindable]
		public var translateColumns:String = '';
		
		private var _selectedColumn:String = '@item_id';
		private var _selectedValue:String = '';
		
		public function List()
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
			var selectedIndex:Number = this.selectedIndex;
			super.dataProvider = value;
			
			if (selectedIndex == -1 && dataProvider.length > 0)
			{
				selectedIndex = 0;
			}
			
			if (selectedIndex > dataProvider.length - 1)
			{
				selectedIndex = dataProvider.length - 1;
			}
			
			this.selectedIndex = selectedIndex;
			
			Core.translate.columns(dataProvider, translateColumns);
			
			callLater(Core.selectItem, [this, selectedColumn, selectedValue]);
		}
	}
}