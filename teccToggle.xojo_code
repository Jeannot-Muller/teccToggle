#tag Class
Protected Class teccToggle
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  // Visual WebSDK controls can "draw" themselves in the IDE
		  
		  g.FontName = "Helvetica"
		  g.FontUnit = FontUnits.Point
		  g.FontSize = 21
		  
		  If BooleanProperty("enabled") = False Then
		    g.Transparency = 60
		  Else
		    g.Transparency = 0
		  End If
		  
		  If BooleanProperty("visible") = True Then
		    Select Case IntegerProperty("CrownPosition")
		    Case 0
		      g.DrawingColor = ColorProperty( "ActiveColor" ) 
		      g.FillRoundRectangle(0, 0, 66, 29, 18, 18)
		      g.DrawingColor = ColorProperty( "ActiveCrown" ) 
		      g.FillOval(40,5,18,18)
		      g.DrawingColor = ColorProperty( "DeactiveColor" ) 
		      g.DrawText( Chr(216), 7, 22 )
		      g.DrawingColor = ColorProperty( "DeactiveCrown" ) 
		      g.FillOval(45,10,8,8)
		    Case 1
		      g.DrawingColor = ColorProperty( "ActiveColor" ) 
		      g.FillRoundRectangle(0, 0, 66, 29, 18, 18)
		      g.DrawingColor = ColorProperty( "ActiveCrown" ) 
		      g.FillOval(10,5,18,18)
		      g.DrawingColor = ColorProperty( "DeactiveColor" ) 
		      g.DrawText( Chr(216), 43, 22 )
		      g.DrawingColor = ColorProperty( "DeactiveCrown" ) 
		      g.FillOval(15,10,8,8)
		    Case 2
		      g.DrawingColor = ColorProperty( "ActiveColor" ) 
		      g.FillRoundRectangle(0, 0, 29, 66, 18, 18)
		      g.DrawingColor = ColorProperty( "ActiveCrown" ) 
		      g.FillOval(5,8,18,18)
		      g.DrawingColor = ColorProperty( "DeactiveColor" ) 
		      g.DrawText( Chr(216), 7, 60 )
		      g.DrawingColor = ColorProperty( "DeactiveCrown" ) 
		      g.FillOval(10,13,8,8)
		    Case 3
		      g.DrawingColor = ColorProperty( "ActiveColor" ) 
		      g.FillRoundRectangle(0, 0, 29, 66, 18, 18)
		      g.DrawingColor = ColorProperty( "ActiveCrown" ) 
		      g.FillOval(5,40,18,18)
		      g.DrawingColor = ColorProperty( "DeactiveColor" ) 
		      g.DrawText( Chr(216), 6, 22 )
		      g.DrawingColor = ColorProperty( "DeactiveCrown" ) 
		      g.FillOval(10,45,8,8)
		    End Select
		  end if
		  
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
		  Case cpositions.top
		    cposition = "270"
		  Case cpositions.Bottom
		    cposition = "90"
		    
		  End Select
		  
		  js.value("off") = passValue
		  js.value("coloron") = "#" + ActiveColor.ToString.Right(6)
		  js.value("coloroff") = "#" + DeactiveColor.ToString.Right(6)
		  js.value("crownposition") = cposition 
		  js.value("activecrown") = "#" + ActiveCrown.ToString.Right(6)
		  js.value("deactivecrown") = "#" + DeactiveCrown.ToString.Right(6)
		  
		  
		  
		  
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
		    css.Add("--deactive-crown: #ff0000;")
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
		    css.Add("height: 1.15rem;")
		    css.Add("width: 1.15rem;")
		    css.Add("border-radius: 100%;")
		    css.Add("display: block;")
		    css.Add("Left: 0.45rem;")
		    css.Add("bottom: 0.3rem;")
		    css.Add("background-Color: var(--crown) !important;")
		    css.Add("transition: all 0.3s;")
		    css.Add("}")
		    
		    css.Add("Input:checked + .roundbutton {")
		    css.Add("background-Color: var(--deactive) !important;")
		    css.Add("}")
		    
		    css.Add("Input:checked + .roundbutton:before  {")
		    css.Add("background-Color: var(--deactive-crown) !important;")
		    css.Add("transition: background-Color;")
		    css.Add("transform: translate(1.9Rem, 0);")
		    css.Add("transition: all 0.3s;")
		    css.Add("}")
		    
		    cssStr = String.FromArray( css, "" )
		    
		    teccToggleCSS = New WebFile
		    teccToggleCSS.Filename = "teccToggle.css"
		    teccToggleCSS.MIMEType = "text/css"
		    teccToggleCSS.data = cssStr
		    teccToggleCSS.Session = Nil 
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
		    JSFramework.Session = Nil 
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

	#tag Method, Flags = &h0
		Sub setCrownPosition(x as integer)
		  Select Case x
		  Case 0
		    CrownPosition = cpositions.right
		  Case 1
		    CrownPosition = cpositions.Left
		  Case 2
		    CrownPosition = cpositions.Top
		  Case 3
		    CrownPosition = cpositions.Bottom
		  End Select
		  
		  UpdateControl
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 4669726573207768656E2074686520636F6E74726F6C20697320636C69636B65642E2052657475726E7320746865206368616E676564207374617475732E0A737461747573203D2074686520737461747573206F662074686520636F6E74726F6C2E0A6F626A6563746964203D20746865206964206F6620746865206372656174656420444F4D20656C656D656E742E
		Event teccToggleClick()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 44657369676E
		ActiveColor As color = &c3D90F8
	#tag EndProperty

	#tag Property, Flags = &h0
		ActiveCrown As color = &cffffff
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D6972726F72
		CrownPosition As cpositions
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 44657369676E
		DeactiveColor As color = &c929292
	#tag EndProperty

	#tag Property, Flags = &h0
		DeactiveCrown As color = &cffffff
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


	#tag Constant, Name = kJSCode, Type = String, Dynamic = False, Default = \"\"use strict\";\nvar tecc;\n(function (tecc) {\n    class teccToggle extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n        }\n        render() {\n            super.render();\n            let el \x3D this.DOMElement();\n            if (!el)\n                return;\n            this.setAttributes(el);\n            var idstr \x3D el.id + \"_teccToggle\";\n            let btn \x3D document.createElement(\"div\");\n            var disabledStr \x3D \"\";\n            var opacityStr \x3D \"\";\n            if (!this.enabled) {\n                disabledStr \x3D \"disabled\x3D\'disabled\'\";\n                opacityStr \x3D \";opacity: 20%\";\n            }\n            ;\n            var iOff \x3D \"\";\n            if (this.off \x3D\x3D true) {\n                iOff \x3D \"checked\x3D\'checked\'\";\n            }\n            ;\n            var cbid \x3D \"ts\" + idstr;\n            btn.innerHTML \x3D \"<label class\x3D\'toggle\'><input id\x3D\'\" + cbid + \"\' + class\x3D\'teccCB\' \" + iOff + \" type\x3D\'checkbox\' \" + disabledStr + \"><span class\x3D\'roundbutton\' style\x3D\'--crown:\" + this.activecrown + \"; --deactive-crown:\" + this.deactivecrown + \"; --deactive:\" + this.coloroff + \"; background-color: \" + this.coloron + opacityStr + \";transform: rotate(\" + this.crownposition + \"deg) scaleX(-1) !important;\" + \"\'></span></label>\";\n            btn.id \x3D idstr;\n            btn.addEventListener(\"click\"\x2C function (event) {\n                var controlObject \x3D XojoWeb.getNamedControl(el.id);\n                var jsonObj \x3D new XojoWeb.JSONItem();\n                jsonObj.set(\'ID\'\x2C el.id);\n                jsonObj.set(\'target\'\x2C event.target.tagName);\n                var c \x3D document.getElementById(cbid).checked;\n                jsonObj.set(\'value\'\x2C !c);\n                controlObject.triggerServerEvent(\'teccToggleClick\'\x2C jsonObj)\x2C true;\n            });\n            this.replaceEveryChild(btn);\n            this.applyTooltip(el);\n            this.applyUserStyle(el);\n        }\n        updateControl(data) {\n            super.updateControl(data);\n            let js \x3D $.parseJSON(data);\n            this.refresh();\n            this.off \x3D js.off;\n            this.coloron \x3D js.coloron;\n            this.crownposition \x3D js.crownposition;\n            this.activecrown \x3D js.activecrown;\n            this.deactivecrown \x3D js.deactivecrown;\n            this.coloroff \x3D js.coloroff;\n        }\n    }\n    tecc.teccToggle \x3D teccToggle;\n})(tecc || (tecc \x3D {}));\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LibraryIcon, Type = String, Dynamic = False, Default = \"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", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NavigatorIcon, Type = String, Dynamic = False, Default = \"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", Scope = Public
	#tag EndConstant


	#tag Enum, Name = cpositions, Type = Integer, Flags = &h0
		Right
		  Left
		  Top
		Bottom
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
			Name="ActiveCrown"
			Visible=true
			Group="teccToggle"
			InitialValue="&cffffff"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DeactiveCrown"
			Visible=true
			Group="teccToggle"
			InitialValue="&cffffff"
			Type="color"
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
				"2 - Top"
				"3 - Bottom"
			#tag EndEnumValues
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
