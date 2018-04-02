package projects.admin.managers
{
	import mx.collections.ArrayCollection;
	
	import engine.core.Core;
	import engine.managers.Menus;
	
	public class Menus extends engine.managers.Menus
	{
		[Bindable]
		public var textsEditorMenu:ArrayCollection;
		
		public function Menus()
		{
			super();
		}
		
		override public function refresh():void
		{
			super.refresh();
			
			startWindowMenu = new ArrayCollection(
				[
					{label: Core.translate.to(['references']), children: new ArrayCollection([
						{label: Core.translate.to(['accounts']), action: 'AccountsReferenceWindow', enabled: false},
						{label: Core.translate.to(['modules']), action: 'ModulesReferenceWindow', enabled: false},
					])},
					{label: Core.translate.to(['reports']), children: new ArrayCollection([
						{label: Core.translate.to(['payments']), action: 'PaymentsReportWindow', enabled: false},
					])},
					{label: Core.translate.to(['tools']), children: new ArrayCollection([
						{label: Core.translate.to(['development']), children: new ArrayCollection([
							{label: Core.translate.to(['references']), children: new ArrayCollection([
								{label: Core.translate.to(['categories']), action: 'DevelopmentCategoriesReferenceWindow', enabled: true},
								{label: Core.translate.to(['priorities']), action: 'DevelopmentPrioritiesReferenceWindow', enabled: true},
								{label: Core.translate.to(['states']), action: 'DevelopmentStatesReferenceWindow', enabled: true},
							])},
							{label: Core.translate.to(['development']), action: 'DevelopmentWindow', enabled: false},
						])},
						{label: Core.translate.to(['locales']), action: 'LocalesWindow', enabled: false},
						{label: Core.translate.to(['logs of_changes']), action: 'LogsReportWindow', enabled: false},
						/*{label: Core.translate.to(['sticky_notes']), action: 'StickyNotesWindow', enabled: false},*/
					])}
				]);
			
			textsEditorMenu = new ArrayCollection(
				[
					{label: Core.translate.to(['user_agreement']), action: '1'},
					{label: Core.translate.to(['privacy_policy']), action: '2'},
				]);
		}
	}
}