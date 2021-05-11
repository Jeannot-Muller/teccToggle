#tag Class
Protected Class teccToggle
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  // Visual WebSDK controls can "draw" themselves in the IDE
		  g.DrawingColor = &cFF0000
		  g.drawoval(0,0,g.Width,g.Height)
		  
		  g.DrawingColor = &c000000
		  g.DrawText "Visual Control", 0, g.Height/2
		End Sub
	#tag EndEvent

	#tag Event
		Function ExecuteEvent(name as string, parameters as JSONItem) As Boolean
		  // Events sent with TriggerServerEvent using your controlID will end up here
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
		  Dim source() As String
		  source.Append("var aggiungi = `")
		  source.Append("<button class='btn' ")
		  'source.Append("style="+Chr(34)+"width:100%;height:100%;background:#"+"FF0000"+";padding:2px; ")
		  'source.Append("color:#"+"FFFFFF"+";text-transform: none;cursor:pointer;")
		  'source.Append("line-height: "+Str(Self.Height)+"px; "+Chr(34)+">")
		  source.Append(">Toggle</button>")
		  source.Append("`;")
		  
		  source.Append("document.getElementById('"+Self.ControlID+"').innerHTML += aggiungi;")
		  
		  'Session.ExecuteJavaScript(Join(source,""))
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  // Use this method to serialize the data your control needs for initial setup
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  // Return an array of CSS URLs for your control
		  // Here's one way to do this...
		  
		  If MyControlCSS = Nil Then
		    MyControlCSS = New WebFile
		    MyControlCSS.Filename = "myclass.css"
		    MyControlCSS.MIMEType = "text/css"
		    MyControlCSS.data = "#" + Self.ControlID + " { color: red }"
		    MyControlCSS.Session = Nil // Very important, so this file will be available to all sessions
		  End If
		  
		  Var urls() As String
		  urls.Append MyControlCSS.URL
		  
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
		  
		  Return urls
		End Function
	#tag EndEvent


	#tag Property, Flags = &h21
		Private Shared JSFramework As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared MyControlCSS As WebFile
	#tag EndProperty


	#tag Constant, Name = kJSCode, Type = String, Dynamic = False, Default = \"var tecc;\n(function (tecc) {\n    class teccToggle extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n        }\n        render() {\n            super.render();\n            let el \x3D this.DOMElement();\n            if (!el)\n                return;\n            this.setAttributes();\n            var idstr \x3D el.id + \"_teccToggle\"        \n            let btn \x3D document.createElement(\"button\");\n            btn.style.cssText \x3D \"width:100%;height:100%;background:#FF0000;padding:2px; color:#FFFFFF; text-transform: none;cursor:pointer;\"\n\t     btn.innerHTML \x3D \"Jeannot\";\n             btn.id \x3D idstr;\n\n             this.replaceEveryChild( btn );\n            this.applyUserStyle();\n        }\n        updateControl(data) {\n            super.updateControl(data);\n            this.refresh();\n        }\n    }\n    tecc.teccToggle\x3D teccToggle;\n})(tecc || (tecc \x3D {}));", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
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
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
