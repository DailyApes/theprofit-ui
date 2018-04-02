package projects.cabinet.managers
{
	import mx.collections.ArrayCollection;
	
	import engine.core.Core;
	import engine.managers.Menus;
	
	public class Menus extends engine.managers.Menus
	{
		public function Menus()
		{
			super();
		}
		
		override public function refresh():void
		{
			super.refresh();
			
			startWindowMenu = new ArrayCollection(
				[
					{label:Core.translate.to(['help']), action:'HelpWindow'},
					/*{label: Core.translate.to(['history']), children: new ArrayCollection([
						{label:Core.translate.to(['balance_refills_history']), action:'BalanceRefillsHistoryWindow'},
						{label:Core.translate.to(['payments_history']), action:'PaymentsHistoryWindow'},
					])},*/
					{label: Core.translate.to(['home_accounting']), children: new ArrayCollection([
						{label: Core.translate.to(['references']), children: new ArrayCollection([
							{label: Core.translate.to(['contributions']), action: 'HAContributionsReferenceWindow'},
							{label: Core.translate.to(['wallets']), action: 'HAWalletsReferenceWindow'},
							{label: Core.translate.to(['contacts']), action: 'HAContactsReferenceWindow'},
						])},
						/*{label: Core.translate.to(['charts']), children: new ArrayCollection([
							{label:Core.translate.to(['by_contributions']), action:'HAByContributionsChartWindow'},
						])},*/
						{label: Core.translate.to(['home_accounting']), action: 'HAWindow'},
					])}
				]);
		}
	}
}