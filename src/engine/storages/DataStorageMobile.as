package engine.storages
{
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import engine.core.CoreMobile;
	
	public class DataStorageMobile
	{
		[Bindable]
		public var getHttpService:HTTPService = new HTTPService();
		
		[Bindable]
		private var _dataProvider:XMLList;
		
		[Bindable]
		public var getHttpServiceModule:String = '';
		[Bindable]
		public var getHttpServiceController:String = '';
		[Bindable]
		public var getHttpServiceAction:String = '';
		
		public function DataStorageMobile()
		{
			super();
			
			getHttpService.addEventListener(FaultEvent.FAULT, CoreMobile.httpService_faultHandler);
			getHttpService.addEventListener(ResultEvent.RESULT, getHttpService_resultHandler);
		}
		
		private function getHttpService_resultHandler(event:ResultEvent):void
		{
			if (CoreMobile.checkErrors(getHttpService))
			{
				dataProvider = event.result.item;
				dispatchEvent(new Event('change'));				
			}
		}
		
		[Bindable]
		public function set dataProvider(value:XMLList):void
		{
			_dataProvider = value;
		}
		
		public function get dataProvider():XMLList
		{
			return _dataProvider
		}
		
		public function refresh(requestParams:Object = null):void
		{
			setup();
			getHttpService.send(requestParams);
		}
		
		private function setup():void
		{
			getHttpService.method = 'POST'
			getHttpService.requestTimeout = CoreMobile.requestTimeout;
			getHttpService.resultFormat = 'e4x'
			getHttpService.concurrency = 'last'
			getHttpService.url = CoreMobile.serverUrl + (CoreMobile.yii ? '/?r=' : '/') + (getHttpServiceModule.length > 0 ? getHttpServiceModule : CoreMobile.getHttpServiceModule) + (getHttpServiceModule.length > 0 || CoreMobile.getHttpServiceModule.length > 0 ? '/' : '') + getHttpServiceController + (getHttpServiceAction.length > 0 ? '/' : '') +  getHttpServiceAction;
		}
	}
}