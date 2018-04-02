package engine.managers
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Group;
	
	import engine.core.Core;

	public class Menus extends Group
	{
		[Bindable]
		public var startWindowMenu:ArrayCollection;
		
		[Bindable]
		public var helpWindowMenu:ArrayCollection;
		
		public function Menus()
		{
			
		}
		
		public function init():void
		{
			Core.translate.addEventListener(Event.CHANGE, locales_changeHandler);
		}
		
		private function locales_changeHandler(event:Event):void
		{
			refresh();
		}
		
		public function refresh():void
		{
			helpWindowMenu = new ArrayCollection(
				[
					{label:Core.translate.to(['about_program']), action:'1'},
					{label: Core.translate.to(['settings / management']), children: new ArrayCollection([
						{label: Core.translate.to(['navigation']), action: '2'},
						{label: Core.translate.to(['windows']), action: '3'},
						{label: Core.translate.to(['tabular_sections']), children: new ArrayCollection([
							{label: Core.translate.to(['tables']), action: '4'},
							{label: Core.translate.to(['filters']), action: '5'},
						])},
						{label: Core.translate.to(['refilling_of_blalnce']), action: '11'}
					])},
					{label: Core.translate.to(['home_accounting']), children: new ArrayCollection([
						{label: Core.translate.to(['it_main window']), action: '6'},
						{label: Core.translate.to(['references']), action: '7'},
						{label: Core.translate.to(['income / outcome']), action: '8'},
						{label: Core.translate.to(['planning']), action: '9'},
						/*{label: Core.translate.to(['payment']), action: '10'},*/
					])},
					/*{label: Core.translate.to(['change_log']), children: new ArrayCollection([
						{label: Core.translate.to(['v. 0.0.1a from 2014.03.17']), action: '200'},
					])}*/
				]);
			//extended override function
		}
	}
}