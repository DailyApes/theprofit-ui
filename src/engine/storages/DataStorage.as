package engine.storages
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import engine.core.Core;
	
	public class DataStorage extends EventDispatcher
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
		
		[Bindable]
		public var getHttpServiceUrl:String = '';
		
		[Bindable]
		public var requestParams:Object = new Object();
		
		[Bindable]
		public var inProgress:Boolean;
		
		[Bindable]
		public var beforeChangeFunction:Function;
		[Bindable]
		public var beforeChangeFunctionParams:Array;
		
		[Bindable]
		public var onChangeFunction:Function;
		[Bindable]
		public var onChangeFunctionParams:Array;
		
		public function DataStorage()
		{
			super();
			
			getHttpService.addEventListener(FaultEvent.FAULT, Core.httpService_faultHandler);
			getHttpService.addEventListener(FaultEvent.FAULT, httpService_faultHandler);
			getHttpService.addEventListener(ResultEvent.RESULT, getHttpService_resultHandler);
		}
		
		private function getHttpService_resultHandler(event:ResultEvent):void
		{
			if (Core.checkErrors(getHttpService) == 0)
			{
				if (Boolean(beforeChangeFunction))
				{
					beforeChangeFunction.apply(null, beforeChangeFunctionParams);
				}
				
				dataProvider = event.result.item;
				
				if (Boolean(onChangeFunction))
				{
					onChangeFunction.apply(null, onChangeFunctionParams);
				}
			}

			inProgress = false;
			
			this['dispatchEvent'](new Event('change'));
		}
		
		public function httpService_faultHandler(event:FaultEvent):void
		{
			inProgress = false;
			this['dispatchEvent'](new FaultEvent('fault'));
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
			if (getHttpServiceController.length > 0 || getHttpServiceUrl.length > 0)
			{
				inProgress = true;
				setup();
				getHttpService.send(requestParams ? requestParams : this.requestParams);
			}
		}
		
		private function setup():void
		{
			getHttpService.method = 'POST'
			getHttpService.requestTimeout = Core.requestTimeout;
			getHttpService.resultFormat = 'e4x'
			getHttpService.concurrency = 'last'
			getHttpService.url = getHttpServiceUrl.length > 0 ? Core.serverUrl + getHttpServiceUrl : (Core.serverUrl + (Core.yii ? '/?r=' : '/') + (getHttpServiceModule.length > 0 ? getHttpServiceModule : Core.getHttpServiceModule) + (getHttpServiceModule.length > 0 || Core.getHttpServiceModule.length > 0 ? '/' : '') + getHttpServiceController + (getHttpServiceAction.length > 0 ? '/' : '') +  getHttpServiceAction);
		}
	}
}