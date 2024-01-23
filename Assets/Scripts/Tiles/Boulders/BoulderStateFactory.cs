using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoulderStateFactory
{
    ActiveBoulder _context;

    public BoulderStateFactory(ActiveBoulder currentContext)
    {
        _context = currentContext;
    }

    public BoulderBaseState Fall()
    {
        return new BoulderFallingState(_context, this);
    }
    public BoulderBaseState Push()
    {
        return new BoulderPushState(_context, this);
    }
    public BoulderBaseState Settle()
    {
        return new BoulderSettleState(_context, this);
    }
    public BoulderBaseState Yield()
    {
        return new BoulderYieldState(_context, this);
    }
}
