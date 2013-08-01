package vo
{
	import com.adobe.utils.StringUtil;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	[Bindable]
	public class CairngormParamVo
	{
		public var classname:String = "";
		public var packagename:String = "";
		public var paramincludetype:String= "";
		public var servicename:String= "";
		public var functionname:String= "";
		public var controllername:String= "";
		public var controller:String= "";
		
		[Bindable]
		public function get delegateText():String{
			var _tempStr:String = "";
			var fs:FileStream = new FileStream();
			fs.open(new File(File.applicationDirectory.nativePath+"/tlp/delegate.tlp"),FileMode.READ);
			_tempStr = fs.readUTFBytes(fs.bytesAvailable);
			_tempStr = strToText(_tempStr);
			fs.close();
			return _tempStr;
		}
		[Bindable]
		public function get commondText():String{
			var _tempStr:String = "";
			var fs:FileStream = new FileStream();
			fs.open(new File(File.applicationDirectory.nativePath+"/tlp/commond.tlp"),FileMode.READ);
			_tempStr = fs.readUTFBytes(fs.bytesAvailable);
			_tempStr = strToText(_tempStr);
			fs.close();
			return _tempStr;
		}
		[Bindable]
		public function get eventText():String{
			var _tempStr:String = "";
			var fs:FileStream = new FileStream();
			fs.open(new File(File.applicationDirectory.nativePath+"/tlp/event.tlp"),FileMode.READ);
			_tempStr = fs.readUTFBytes(fs.bytesAvailable);
			_tempStr = strToText(_tempStr);
			fs.close();
			return _tempStr;
		}
		[Bindable]
		public function get modellocatorText():String{
			var _tempStr:String = "";
			var fs:FileStream = new FileStream();
			fs.open(new File(File.applicationDirectory.nativePath+"/tlp/modellocator.tlp"),FileMode.READ);
			_tempStr = fs.readUTFBytes(fs.bytesAvailable);
			_tempStr = strToText(_tempStr);
			fs.close();
			return _tempStr;
		}
		
		private function getParam():Array{
			if(!paramincludetype){
				return null;
			}
			var paramArray:Array = new Array();
			var _tempParam:Array =  paramincludetype.split(",");
			var param:String = "";
			var myeventparam:String = "";
			var _publicvarparamincludetype:String = "";
			var _thisparamincludetype:String = "";
			for(var i:int=0;i<_tempParam.length;i++){
				var _tempParam2:Array = _tempParam[i].toString().split(":");
				param += param?(","+_tempParam2[0]):_tempParam2[0];
				myeventparam += myeventparam?(",myEvent."+_tempParam2[0]):"myEvent."+_tempParam2[0];
				_publicvarparamincludetype += "		public var "+_tempParam[i].toString()+";\n";
				_thisparamincludetype += "			this."+_tempParam2[0]+" = "+_tempParam2[0]+";\n";
			}
			paramArray.push(param);
			paramArray.push(myeventparam);
			paramArray.push(_publicvarparamincludetype);
			paramArray.push(_thisparamincludetype);
			return paramArray;
		}
		
		private function strToText(_str:String):String{
			var _param:String = "";
			var _myeventparam:String = "";
			var _publicvarparamincludetype:String = "";
			var _thisparamincludetype:String = "";
			if(this.getParam()){
				_param = this.getParam()[0].toString();
				_myeventparam = this.getParam()[1].toString();
				_publicvarparamincludetype = this.getParam()[2].toString();
				_thisparamincludetype = this.getParam()[3].toString();
			}
			_str = StringUtil.replace(_str,"@_package@",this.packagename);
			_str = StringUtil.replace(_str,"@_classname@",this.classname);
			_str = StringUtil.replace(_str,"@_function@",this.functionname);
			_str = StringUtil.replace(_str,"@_paramincludetype@",this.paramincludetype);
			if(this.paramincludetype){
				_str = StringUtil.replace(_str,"@_responseFunParam@",",responseFun:Function");
			}else{
				_str = StringUtil.replace(_str,"@_responseFunParam@","responseFun:Function");
			}
			_str = StringUtil.replace(_str,"@_servicename@",this.servicename);
			_str = StringUtil.replace(_str,"@_param@",_param);
			_str = StringUtil.replace(_str,"@_myeventparam@",_myeventparam);
			_str = StringUtil.replace(_str,"@_publicvarparamincludetype@",_publicvarparamincludetype);
			_str = StringUtil.replace(_str,"@_thisparamincludetype@",_thisparamincludetype);
			_str = StringUtil.replace(_str,"@_controllername@",this.controllername);
			_str = StringUtil.replace(_str,"@_controller@",this.controller);
			var controllerClass:String = this.controller.substring(this.controller.lastIndexOf(".")+1,this.controller.length);
			_str = StringUtil.replace(_str,"@_controllerClass@",controllerClass);
			return  _str;
		}
	}
}