package com.teotigraphix.frameworks.midi.scale
{
public class ScaleCollection
{
    private var _scaleItems:Vector.<ScaleItem> = new Vector.<ScaleItem>();

    private var _gridSize:int = 8;

    [Transient]
    private var _scales:Vector.<ScaleReference>;
    
    
    //----------------------------------
    // scaleItems
    //----------------------------------
    
    public function get scaleItems():Vector.<ScaleItem>
    {
        return _scaleItems;
    }
    
    public function set scaleItems(value:Vector.<ScaleItem>):void
    {
        _scaleItems = value;
    }
    
    //----------------------------------
    // gridSize
    //----------------------------------
    
    public function get gridSize():int
    {
        return _gridSize;
    }
    
    public function set gridSize(value:int):void
    {
        _gridSize = gridSize;
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    /**
     * @param defaultScales ScaleReference.values
     */
    public function ScaleCollection(defaultScales:Vector.<ScaleReference> = null)
    {
        if (defaultScales == null)
            return;
        
        _scales = defaultScales;
        
        stateChanged();
    }
    
    //--------------------------------------------------------------------------
    // API :: Methods
    //--------------------------------------------------------------------------
    
    /**
     * Call after setting properties that change the scale grid.
     */
    public function stateChanged():void
    {
        var len:int = _scales.length;
        _scaleItems = new Vector.<ScaleItem>(len, true);
        
        for (var i:int = 0; i < len; i++)
        {
            _scaleItems[i] = createScale(_scales[i]);
        }
    }
    
    //--------------------------------------------------------------------------
    // Private :: Methods
    //--------------------------------------------------------------------------
    
    private function createScale(scale:ScaleReference):ScaleItem
    {
        var midiNotes:Vector.<int> = scale.intervals;
        
        var len:int = midiNotes.length;
        var matrix:Vector.<int> = new Vector.<int>(_gridSize);
        
        for (var index:int = 0; index < _gridSize; index++)
        {
            matrix[index] = ((Math.floor(index / len)) * 12 + midiNotes[index % len]);
        }
        
        return new ScaleItem(scale.name, scale.id, matrix);
    }
}
}