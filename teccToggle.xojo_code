#tag Class
Protected Class teccToggle
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  // Visual WebSDK controls can "draw" themselves in the IDE
		  g.DrawingColor = &c000000
		  g.DrawText "teccToggle", 0, g.Height/2
		  
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
		    Case "onItemClick"
		      
		      Try
		        If Parameters.HasName("ID") Then
		          Var test1 As String = Parameters.value("ID")
		          Var test2 As String = Me.ControlID
		          
		          
		          If Me.Enabled Then
		            onItemClick()
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
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  // Use this method to serialize the data your control needs for initial setup
		  js.Value("powered") = Powered
		  js.Value("display") = Display.tostring.Right(6)
		  
		  
		  
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
		  css.Add("background-Color: #000000" )
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


	#tag Hook, Flags = &h0
		Event onItemClick()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 446973706C6179
		Display As color = &c00f900
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared JSFramework As WebFile
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 506F7765726564
		Powered As boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared teccToggleCSS As WebFile
	#tag EndProperty


	#tag Constant, Name = kJSCode, Type = String, Dynamic = False, Default = \"var tecc;\n(function (tecc) {\n    class teccToggle extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n        }\n        render() {\n            super.render();\n            let el \x3D this.DOMElement();\n            if (!el)\n                return;\n            this.setAttributes();\n\n            var idstr \x3D el.id + \"_teccToggle\"        \n            let btn \x3D document.createElement(\"div\");\n            //btn.style.cssText \x3D \"text-transform: none;cursor:pointer;\"\n            var disabledStr \x3D \"\";\n             if (!this.enabled) { disabledStr \x3D \"disabled\x3D\'disabled\'\"};\n            var onColorStr \x3D \"\";\n             onColorStr\x3D \"style\x3D\'background-color: #\" + this.display + \"\' }}\" ;\n            var checkedStr \x3D \"\";\n             if ( !this.powered  ) {checkedStr\x3D\"checked\"} else { checkedStr\x3D\"\" };\n\t     btn.innerHTML \x3D \"<label class\x3D\'toggle\'><input id\x3D\'toggleswitch\' \" + checkedStr + \" class\x3D\'teccCB\' type\x3D\'checkbox\'\" + disabledStr + \"><span class\x3D\'roundbutton\' \" + onColorStr +\"></span></label>\";\n             btn.id \x3D idstr;\nvar controlObject \x3D XojoWeb.getNamedControl( el.id );\nvar jsonObj \x3D new XojoWeb.JSONItem(); \n\njsonObj.set(\'ID\'\x2Cel.id); \n             btn.addEventListener(\"click\"\x2C function(event) { controlObject.triggerServerEvent(\'onItemClick\'\x2C jsonObj); }\x2C true);\n             this.replaceEveryChild( btn );\n \t      this.applyTooltip(el);\n            this.applyUserStyle(el);\n            //this.applyUserStyle();\n        }\n        updateControl(data) {\n            super.updateControl(data);\nlet js \x3D $.parseJSON(data);\nthis.display \x3D js.display;\nthis.powered \x3D js.powered;\n            this.refresh();\n        }\n    }\n    tecc.teccToggle\x3D teccToggle;\n})(tecc || (tecc \x3D {}));", Scope = Private
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
			Name="Display"
			Visible=true
			Group="Behavior"
			InitialValue="&c00f900"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Powered"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
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
