using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class BoulderBaseState
{
    protected ActiveBoulder _context;
    protected BoulderStateFactory _factory;
    //protected BoulderBaseState _previousState;

    public BoulderBaseState(ActiveBoulder currentContext, BoulderStateFactory stateFactory)
    {
        _context = currentContext;
        _factory = stateFactory;
    }
    abstract public void EnterState();
    abstract public void ExitState();

    abstract public void CheckSwitchState();
    abstract public void UpdateState();

    abstract public void OnCollisionEnter(Collision2D collision);

    protected void SwitchStates(BoulderBaseState state)
    {
        ExitState();
        //state._previousState = this;
        state.EnterState();

        _context.CurrentState = state;
    }

/*
    protected void RewindState()
    {
        ExitState();
        _previousState.EnterState();

        _context.CurrentState = _previousState;
    }
    */

    public virtual void SetYieldDistance(float f)
    {

    }
}
