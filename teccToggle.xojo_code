#tag Class
Protected Class teccToggle
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  // Visual WebSDK controls can "draw" themselves in the IDE
		  g.DrawingColor = &c3D90F8
		  g.FillRoundRectangle(0, 0, 66, 29, 18, 18)
		  g.DrawingColor = &cFFFFFF
		  g.FillOval(40,5,18,18)
		  
		  If BooleanProperty("enabled") = False Then
		    g.Transparency = 60
		  Else
		    g.Transparency = 0
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function ExecuteEvent(name as string, parameters as JSONItem) As Boolean
		  // Events sent with TriggerServerEvent using your controlID will end up here
		  Try
		    
		    Select Case Name
		    Case "teccToggleClick"
		      
		      Try
		        If parameters.value("target") = "INPUT" Then
		          If Me.Enabled Then
		            mobjectid = Parameters.value("ID")
		            mvalue = Parameters.value("value")
		            If mvalue = True Then mstatus = "on" Else mstatus = "off"
		            If mvalue = True Then mflag = 0 Else mflag = -1
		            
		            teccToggleClick()
		            
		            Return True
		          End If 
		        End If
		      Catch err As OutOfBoundsException
		        
		      End Try
		      
		    End Select
		    
		  Catch
		    
		  End Try
		End Function
	#tag EndEvent

	#tag Event
		Function HandleRequest(Request As WebRequest, Response As WebResponse) As Boolean
		  // Requests sent to the session with the following pattern
		  // 
		  // /<Session Identifier>/sdk/<controlID>/request_path
		  break
		  
		End Function
	#tag EndEvent

	#tag Event
		Function JavaScriptClassName() As String
		  // Name of your JavaScript class which extends XojoWeb.XojoVisualControl
		  Return "tecc.teccToggle"
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.Style.value("outline") = "none"
		  If InitiallyOff = True Then
		    mvalue = False
		  Else
		    mvalue = True
		  End If
		  
		  If mvalue = True Then mstatus = "on" Else mstatus = "off"
		  If mvalue = True Then mflag = 0 Else mflag = -1
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  // Use this method to serialize the data your control needs for initial setup
		  js.value("off") = InitiallyOff
		  js.value("coloron") = "#" + Design.ToString.Right(6)
		  js.value("mirror") = Mirror
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  // Return an array of CSS URLs for your control
		  // Here's one way to do this...
		  
		  Var cssStr As String
		  Var css() As String
		  
		  css.Add(".toggle {")
		  css.Add("margin:0 0 0 2rem;")
		  css.Add("position: relative;")
		  css.Add("display: inline-block;")
		  css.Add("width: 4rem;")
		  css.Add("height: 1.7rem;")
		  css.Add("}")
		  
		  css.Add(".toggle Input {")
		  css.Add("display: none;")
		  css.Add("}")
		  
		  css.Add(".roundbutton {")
		  css.Add("position: absolute;")
		  css.Add("top: 0;")
		  css.Add("Left: -33px;")
		  css.Add("bottom: 0;")
		  css.Add("Right: 0;")
		  css.Add("width: 100%;")
		  css.Add("background-Color: #33455e;")
		  css.Add("display: block;")
		  css.Add("transition: all 0.3s;")
		  css.Add("border-radius: 1.7rem;")
		  css.Add("cursor: pointer;")
		  css.Add("}")
		  
		  css.Add(".roundbutton:before {")
		  css.Add("position: absolute;")
		  css.Add("content: '';")
		  css.Add("height: 1.1rem;")
		  css.Add("width: 1.2rem;")
		  css.Add("border-radius: 100%;")
		  css.Add("display: block;")
		  css.Add("Left: 0.5rem;")
		  css.Add("bottom: 0.31rem;")
		  css.Add("background-Color: white;")
		  css.Add("transition: all 0.3s;")
		  css.Add("}")
		  
		  css.Add("Input:checked + .roundbutton {")
		  css.Add("background-Color: #929292 !important;")
		  css.Add("}")
		  
		  css.Add("Input:checked + .roundbutton:before  {")
		  css.Add("transform: translate(1.9Rem, 0);")
		  css.Add("}")
		  
		  cssStr = Join(css, "" )
		  
		  If teccToggleCSS = Nil Then
		    teccToggleCSS = New WebFile
		    teccToggleCSS.Filename = "teccToggle.css"
		    teccToggleCSS.MIMEType = "text/css"
		    teccToggleCSS.data = cssStr
		    teccToggleCSS.Session = Nil // Very important, so this file will be available to all sessions
		  End If
		  
		  Var urls() As String
		  urls.Append teccToggleCSS.URL
		  
		  Return urls
		End Function
	#tag EndEvent

	#tag Event
		Function SessionHead(session as WebSession) As String
		  // Return anything that you needed added to the <head> of the web app
		End Function
	#tag EndEvent

	#tag Event
		Function SessionJavascriptURLs(session as WebSession) As String()
		  If JSFramework = Nil Then
		    JSFramework = New WebFile
		    JSFramework.Filename = "teccToggle.js"
		    JSFramework.MIMEType ="text/javascript"
		    JSFramework.data = kJSCode
		    JSFramework.Session = Nil // Very important, so this file will be available to all sessions
		  End If
		  
		  Dim urls() As String
		  urls.Append JSFramework.URL
		  'Call DoEnabled()
		  
		  Return urls
		End Function
	#tag EndEvent


	#tag Hook, Flags = &h0, Description = 4669726573207768656E2074686520636F6E74726F6C20697320636C69636B65642E2052657475726E7320746865206368616E676564207374617475732E0A737461747573203D2074686520737461747573206F662074686520636F6E74726F6C2E0A6F626A6563746964203D20746865206964206F6620746865206372656174656420444F4D20656C656D656E742E
		Event teccToggleClick()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 44657369676E
		Design As color = &c3D90F8
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mflag
			End Get
		#tag EndGetter
		flag As integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 496E697469616C6C79204F4646
		InitiallyOff As boolean = false
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared JSFramework As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mflag As integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D6972726F72
		Mirror As boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mobjectid As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mstatus As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mvalue As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mobjectid
			End Get
		#tag EndGetter
		objectid As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mstatus
			End Get
		#tag EndGetter
		status As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared teccToggleCSS As WebFile
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mvalue
			End Get
		#tag EndGetter
		value As boolean
	#tag EndComputedProperty


	#tag Constant, Name = kJSCode, Type = String, Dynamic = False, Default = \"var tecc;\n(function (tecc) {\n    class teccToggle extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n        }\n        render() {\n            super.render();\n            let el \x3D this.DOMElement();\n            if (!el)\n                return;\n            this.setAttributes();\n            var idstr \x3D el.id + \"_teccToggle\" ;      \n            let btn \x3D document.createElement(\"div\");\n            var disabledStr \x3D \"\";\n            if (!this.enabled) { disabledStr \x3D \"disabled\x3D\'disabled\'\"};\n            var iOff \x3D \"\";\n            if (this.off\x3D\x3Dtrue) { iOff\x3D \"checked\x3D\'checked\'\"};\n            var cbid \x3D \"ts\" + idstr;\n            var mirror \x3D \"; transform: rotate(360deg) scaleX(-1);\'\";\n            if (this.mirror\x3D\x3Dtrue) { mirror \x3D \"\" };\n\t        btn.innerHTML \x3D \"<label class\x3D\'toggle\'\" +mirror + \"><input id\x3D\'\" + cbid + \"\' + class\x3D\'teccCB\' \" + iOff + \" type\x3D\'checkbox\' \" + disabledStr + \"><span class\x3D\'roundbutton\' style\x3D\'background-color: \" + this.coloron +  mirror + \"\'></span></label>\";\n            btn.id \x3D idstr;\n            btn.addEventListener(\"click\"\x2C function(event) { \n\t\t\t    var controlObject \x3D XojoWeb.getNamedControl( el.id );\n\t\t\t    var jsonObj \x3D new XojoWeb.JSONItem(); \n\t\t\t    jsonObj.set(\'ID\'\x2Cel.id); \n\t\t\t    jsonObj.set(\'target\'\x2Cevent.target.tagName); \n                var c \x3D document.getElementById(cbid).checked\n                jsonObj.set(\'value\'\x2C !c);\n\t\t\t    controlObject.triggerServerEvent(\'teccToggleClick\'\x2C jsonObj)\x2C true\n\t\t        });\n            this.replaceEveryChild( btn );\n            this.applyTooltip(el);\n            this.applyUserStyle();\n        }\n        updateControl(data) {\n            super.updateControl(data);\n            let js \x3D $.parseJSON(data);\n            this.refresh();\n            this.off \x3D js.off;\n            this.mirror \x3D js.mirror;\n \t    this.coloron \x3D js.coloron;\n        }\n    }\n    tecc.teccToggle\x3D teccToggle;\n})(tecc || (tecc \x3D {}));", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="34"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="objectid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="flag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="status"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Visual Controls"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitiallyOff"
			Visible=true
			Group="teccToggle"
			InitialValue="false"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mirror"
			Visible=true
			Group="teccToggle"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Design"
			Visible=true
			Group="teccToggle"
			InitialValue="&c3D90F8"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Indicator"
			Visible=false
			Group="Visual Controls"
			InitialValue=""
			Type="WebUIControl.Indicators"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Primary"
				"2 - Secondary"
				"3 - Success"
				"4 - Danger"
				"5 - Warning"
				"6 - Info"
				"7 - Light"
				"8 - Dark"
				"9 - Link"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
