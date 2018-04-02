package engine.extended
{
	import spark.components.TextArea;
	
	import engine.skins.TextAreaSkin
	
	public class TextArea extends spark.components.TextArea
	{
		public function TextArea()
		{
			super();
			
			setStyle('skinClass', TextAreaSkin);
		}
	}
}