package forms.systems;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import forms.components.Display;
import forms.components.Position;
import forms.nodes.RenderNode;

class RenderSystem extends System
{
    public var container:DisplayObjectContainer;

    private var nodes:NodeList<RenderNode>;

    public function new(container:DisplayObjectContainer)
    {
        super();
        this.container = container;
    }

    override public function addToEngine(engine:Engine):Void
    {
        nodes = engine.getNodeList(RenderNode);
        for (node in nodes)
            addToDisplay(node);
        nodes.nodeAdded.add(addToDisplay);
        nodes.nodeRemoved.add(removeFromDisplay);
    }

    private function addToDisplay(node:RenderNode):Void
    {
        container.addChild(node.displayObject);
    }

    private function removeFromDisplay(node:RenderNode):Void
    {
        container.removeChild(node.displayObject);
    }

    override public function update(time:Float):Void
    {
        for (node in nodes)
        {
            var displayObject:DisplayObject = node.displayObject;
            var position:Position = node.position;

            displayObject.x = position.position.x;
            displayObject.y = position.position.y;
            displayObject.rotation = position.rotation * 180 / Math.PI;
        }
    }

    override public function removeFromEngine(engine:Engine):Void
    {
        nodes = null;
    }
}
