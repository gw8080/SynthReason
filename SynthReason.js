/* 
   Copyright (C) 2020 George Wagenknecht SynthReason, This program is free
   software; you can redistribute it and/or modify it under the terms of the
   GNU General Public License as published by the Free Software Foundation;
   either version 2 of the License, or (at your option) any later version.
   This program is distributed in the hope that it will be useful, but WITHOUT 
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
   more details. You should have received a copy of the GNU General Public
   License along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */

var resource = "/sdcard/uber.txt";
var rules = "/sdcard/reason.txt";
var output = "";
var txt = "";
function OnStart()
{
	lay = app.CreateLayout("linear", "VCenter,FillXY");
	edt = app.CreateTextEdit("output", 0.96, 0.6);
	edt.SetTextSize(7);
	lay.AddChild(edt);
	btnLoad = app.CreateButton("init", 0.23, 0.1);
	btnLoad.SetOnTouch(btnLoad_OnTouch);
	lay.AddChild(btnLoad);
	app.AddLayout(lay);
}

function btnLoad_OnTouch()
{
	var count = 0;
	var vocabproc = "";
	var vocabsyn = "";
	for (count = 0; count < 100; count++)
	{
		vocabproc = app.ReadFile("/sdcard/test/" + count + ".txt");
		if (vocabproc.length > 0)
		{
			vocabsyn += vocabproc + ":::::";
		}
		if (vocabproc.length == 0)
		{
			break;
		}
	}

	var KB = app.ReadFile(rules);
	var enx = KB.split(" ");
	var vocabprep = vocabsyn.split(":::::");
	for (var x = 0; x < enx.length; x++)
	{
		for (var y = 0; y < vocabprep.length; y++)
		{
			if (vocabprep[y].indexOf("\n" + enx[x] + "\n") > -1)
			{
				txt += y + ",";
				break;
			}
		}
	}
	var KB = app.ReadFile(resource);
	var en = KB.split(" ");
	var cat = txt.split(",");
	for (var b = 0; b != cat.length - 1; b++)
	{
		for (var i = Math.floor(Math.random() * en.length); i < en.length; i++)
		{
			if (vocabprep[cat[b]].indexOf("\n" + en[i] + "\n") > -1)
			{
				output += en[i] + " ";
				app.SetClipboardText(output);
				edt.SetText(output);
				break;
			}
		}
	}
}
