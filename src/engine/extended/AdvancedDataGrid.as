package engine.extended
{
	import flash.display.Sprite;
	
	import mx.controls.AdvancedDataGrid;
	import mx.core.EdgeMetrics;
	
	
	public class AdvancedDataGrid extends mx.controls.AdvancedDataGrid
	{
		public function AdvancedDataGrid()
		{
			super();
		}
		
		public function paintRow(rowNumber:Number, color:uint):void
		{
			var rowBGs:Sprite = Sprite(listContent.getChildByName("rowBGs"));
			drawRowBackground(rowBGs, rowNumber, 0, 20, color, 1);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			layoutChrome(unscaledWidth, unscaledHeight);
			
			var w:Number = unscaledWidth;
			var h:Number = unscaledHeight;
			
			var vm:EdgeMetrics = viewMetrics;
			
			if (horizontalScrollBar && horizontalScrollBar.visible)
			{
				horizontalScrollBar.setActualSize(w - vm.left - vm.right + 2,
					horizontalScrollBar.minHeight);
				horizontalScrollBar.move(vm.left - 1,
					h - vm.bottom + 1);
				
				horizontalScrollBar.enabled = enabled;
			}
			
			if (verticalScrollBar && verticalScrollBar.visible)
			{
				verticalScrollBar.setActualSize(verticalScrollBar.minWidth,
					h - vm.top - vm.bottom + 2);
				verticalScrollBar.move(w - vm.right + 1, vm.top - 1);
				
				verticalScrollBar.enabled = enabled;
			}
		}
	}
}