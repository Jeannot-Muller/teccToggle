#tag Class
Protected Class teccToggle
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  // Visual WebSDK controls can "draw" themselves in the IDE
		  
		  Select Case IntegerProperty("CrownPosition")
		  Case 0
		    Var activeColor As Color = ColorProperty( "ActiveColor" ) 
		    g.DrawingColor = activeColor
		    g.FillRoundRectangle(0, 0, 66, 29, 18, 18)
		    Var crownColor As Color = ColorProperty( "CrownColor" ) 
		    g.DrawingColor = crownColor
		    g.FillOval(40,5,18,18)
		  Case 1
		    Var activeColor As Color = ColorProperty( "ActiveColor" ) 
		    g.DrawingColor = activeColor
		    g.FillRoundRectangle(0, 0, 66, 29, 18, 18)
		    Var crownColor As Color = ColorProperty( "CrownColor" ) 
		    g.DrawingColor = crownColor
		    g.FillOval(10,5,18,18)
		  Case 2
		    Var activeColor As Color = ColorProperty( "ActiveColor" ) 
		    g.DrawingColor = activeColor
		    g.FillRoundRectangle(0, 0, 29, 66, 18, 18)
		    Var crownColor As Color = ColorProperty( "CrownColor" ) 
		    g.DrawingColor = crownColor
		    g.FillOval(5,8,18,18)
		  Case 3
		    Var activeColor As Color = ColorProperty( "ActiveColor" ) 
		    g.DrawingColor = activeColor
		    g.FillRoundRectangle(0, 0, 29, 66, 18, 18)
		    Var crownColor As Color = ColorProperty( "CrownColor" ) 
		    g.DrawingColor = crownColor
		    g.FillOval(5,40,18,18)
		  End Select
		  
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
		            objectid = Parameters.value("ID")
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
		  #Pragma unused Request
		  #Pragma unused Response
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
		  mvalue = True
		  If InitiallyOff = True Then
		    mvalue = False
		  End If
		  Call refreshValues()
		  
		  
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  // Use this method to serialize the data your control needs for initial setup
		  Var passValue As Boolean
		  If mvalue = True Then
		    passValue = False
		  Else
		    passValue = True
		  End If
		  
		  Var cposition As String = "0"
		  Select Case CrownPosition 
		  Case cpositions.Right
		    cposition = "360"
		  Case cpositions.Left
		    cposition = "180"
		  Case cpositions.Up
		    cposition = "270"
		  Case cpositions.Down
		    cposition = "90"
		    
		  End Select
		  
		  js.value("off") = passValue
		  js.value("coloron") = "#" + ActiveColor.ToString.Right(6)
		  js.value("coloroff") = "#" + DeactiveColor.ToString.Right(6)
		  js.value("crownposition") = cposition 
		  js.value("crowncolor") = "#" + CrownColor.ToString.Right(6)
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  #Pragma unused Session
		  // Return an array of CSS URLs for your control
		  // Here's one way to do this...
		  
		  If teccToggleCSS = Nil Then
		    Var cssStr As String
		    Var css() As String
		    
		    css.Add(".toggle {")
		    css.Add("margin:0 0 0 2rem;")
		    css.Add("position: relative;")
		    css.Add("display: inline-block;")
		    css.Add("width: 4rem;")
		    css.Add("height: 1.7rem;")
		    css.Add("--crown: white;")
		    css.Add("--deactive: #929292;")
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
		    css.Add("background-Color: var(--crown);")
		    css.Add("transition: all 0.3s;")
		    css.Add("}")
		    
		    css.Add("Input:checked + .roundbutton {")
		    css.Add("background-Color: var(--deactive) !important;")
		    css.Add("}")
		    
		    css.Add("Input:checked + .roundbutton:before  {")
		    css.Add("transform: translate(1.9Rem, 0);")
		    css.Add("}")
		    
		    cssStr = String.FromArray( css, "" )
		    
		    teccToggleCSS = New WebFile
		    teccToggleCSS.Filename = "teccToggle.css"
		    teccToggleCSS.MIMEType = "text/css"
		    teccToggleCSS.data = cssStr
		    teccToggleCSS.Session = Nil // Very important, so this file will be available to all sessions
		  End If
		  
		  Var urls() As String
		  urls.Add( teccToggleCSS.URL )
		  
		  Return urls
		End Function
	#tag EndEvent

	#tag Event
		Function SessionHead(session as WebSession) As String
		  #Pragma unused session
		  // Return anything that you needed added to the <head> of the web app
		End Function
	#tag EndEvent

	#tag Event
		Function SessionJavascriptURLs(session as WebSession) As String()
		  #Pragma unused session
		  If JSFramework = Nil Then
		    JSFramework = New WebFile
		    JSFramework.Filename = "teccToggle.js"
		    JSFramework.MIMEType ="text/javascript"
		    JSFramework.data = kJSCode
		    JSFramework.Session = Nil // Very important, so this file will be available to all sessions
		  End If
		  
		  Dim urls() As String
		  urls.Add( JSFramework.URL )
		  
		  Return urls
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub refreshValues()
		  'If InitiallyOff = True Then
		  'mvalue = False
		  'Else
		  'mvalue = True
		  'End If
		  
		  
		  If mvalue = True Then mstatus = "on" Else mstatus = "off"
		  If mvalue = True Then mflag = 0 Else mflag = -1
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 4669726573207768656E2074686520636F6E74726F6C20697320636C69636B65642E2052657475726E7320746865206368616E676564207374617475732E0A737461747573203D2074686520737461747573206F662074686520636F6E74726F6C2E0A6F626A6563746964203D20746865206964206F6620746865206372656174656420444F4D20656C656D656E742E
		Event teccToggleClick()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 44657369676E
		ActiveColor As color = &c3D90F8
	#tag EndProperty

	#tag Property, Flags = &h0
		CrownColor As color = &cffffff
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D6972726F72
		CrownPosition As cpositions
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 44657369676E
		DeactiveColor As color = &c929292
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

	#tag Property, Flags = &h21
		Private mstatus As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUntitled As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			mValue = value
		#tag EndNote
		Private mvalue As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private objectid As string
	#tag EndProperty

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
		#tag Setter
			Set
			  mvalue = value
			  
			  Call refreshValues()
			  Call teccToggleClick()
			End Set
		#tag EndSetter
		value As boolean
	#tag EndComputedProperty


	#tag Constant, Name = kJSCode, Type = String, Dynamic = False, Default = \"\"use strict\";\nvar tecc;\n(function (tecc) {\n    class teccToggle extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n        }\n        render() {\n            super.render();\n            let el \x3D this.DOMElement();\n            if (!el)\n                return;\n            this.setAttributes();\n            var idstr \x3D el.id + \"_teccToggle\";\n            let btn \x3D document.createElement(\"div\");\n            var disabledStr \x3D \"\";\n            var opacityStr \x3D \"\";\n            if (!this.enabled) {\n                disabledStr \x3D \"disabled\x3D\'disabled\'\";\n                opacityStr \x3D \";opacity: 20%\";\n            }\n            ;\n            var iOff \x3D \"\";\n            if (this.off \x3D\x3D true) {\n                iOff \x3D \"checked\x3D\'checked\'\";\n            }\n            ;\n            var cbid \x3D \"ts\" + idstr;\n            btn.innerHTML \x3D \"<label class\x3D\'toggle\'><input id\x3D\'\" + cbid + \"\' + class\x3D\'teccCB\' \" + iOff + \" type\x3D\'checkbox\' \" + disabledStr + \"><span class\x3D\'roundbutton\' style\x3D\'--crown:\" + this.crowncolor + \";--deactive:\" + this.coloroff + \"; background-color: \" + this.coloron + opacityStr + \";transform: rotate(\" + this.crownposition + \"deg) scaleX(-1) !important;\" + \"\'></span></label>\";\n            btn.id \x3D idstr;\n            btn.addEventListener(\"click\"\x2C function (event) {\n                var controlObject \x3D XojoWeb.getNamedControl(el.id);\n                var jsonObj \x3D new XojoWeb.JSONItem();\n                jsonObj.set(\'ID\'\x2C el.id);\n                jsonObj.set(\'target\'\x2C event.target.tagName);\n                var c \x3D document.getElementById(cbid).checked;\n                jsonObj.set(\'value\'\x2C !c);\n                controlObject.triggerServerEvent(\'teccToggleClick\'\x2C jsonObj)\x2C true;\n            });\n            this.replaceEveryChild(btn);\n            this.applyTooltip(el);\n            this.applyUserStyle();\n        }\n        updateControl(data) {\n            super.updateControl(data);\n            let js \x3D $.parseJSON(data);\n            this.refresh();\n            this.off \x3D js.off;\n            this.coloron \x3D js.coloron;\n            this.crownposition \x3D js.crownposition;\n            this.crowncolor \x3D js.crowncolor;\n            this.coloroff \x3D js.coloroff;\n        }\n    }\n    tecc.teccToggle \x3D teccToggle;\n})(tecc || (tecc \x3D {}));\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LibraryIcon, Type = String, Dynamic = False, Default = \"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", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NavigatorIcon, Type = String, Dynamic = False, Default = \"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", Scope = Public
	#tag EndConstant


	#tag Enum, Name = cpositions, Type = Integer, Flags = &h0
		Right
		  Left
		  Up
		Down
	#tag EndEnum


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
			Name="CrownPosition"
			Visible=true
			Group="teccToggle"
			InitialValue=""
			Type="cpositions"
			EditorType="Enum"
			#tag EnumValues
				"0 - Right"
				"1 - Left"
				"2 - Up"
				"3 - Down"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveColor"
			Visible=true
			Group="teccToggle"
			InitialValue="&c3D90F8"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DeactiveColor"
			Visible=true
			Group="teccToggle"
			InitialValue="&c929292"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CrownColor"
			Visible=true
			Group="teccToggle"
			InitialValue="&cffffff"
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
