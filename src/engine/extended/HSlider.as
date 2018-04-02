package engine.extended
{
	import spark.components.HSlider;
	
	public class HSlider extends spark.components.HSlider
	{
		public function HSlider()
		{
			super();
		}
		
		[Bindable]
		override public function set minimum(value:Number):void
		{
			super.minimum = value;
		}
		
		[Bindable]
		override public function set maximum(value:Number):void
		{
			super.maximum = value;
		}
	}
}