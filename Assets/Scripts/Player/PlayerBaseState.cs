using UnityEngine;

public abstract class PlayerBaseState
{
    protected bool _isRootState = false;

    protected PlayerController _context;
    protected PlayerStateFactory _factory;
    protected PlayerBaseState _currentSuperState;
    protected PlayerBaseState _currentSubState;

    public PlayerBaseState(PlayerController currentContext, PlayerStateFactory currentFactory)
    {
        _context = currentContext;
        _factory = currentFactory;
    }

    public abstract void EnterState();

    public abstract void UpdateState();

    public abstract void ExitState();

    public abstract void CheckSwitchState();

    public abstract void InitializeSubstate();

    public abstract void OnTriggerEnter(Collider2D collision);
    public abstract void OnTriggerExit(Collider2D collision);
    public abstract void OnCollisionEnter(Collision2D collision);
    public abstract void OnCollisionExit(Collision2D collision);

    public  void UpdateStates()
    {
        UpdateState();
        _currentSubState?.UpdateStates();
    }
    protected void SwitchState(PlayerBaseState newState)
    {
        ExitState();
        newState.EnterState();

        if (_isRootState)
        {
            _context.CurrentState = newState;
        }
        else if (_currentSuperState != null)
        {
            _currentSuperState.SetSubState(newState);
        }
    }
    protected void SetSuperState(PlayerBaseState newSuperState)
    {
        _currentSuperState = newSuperState;
    }
    protected void SetSubState(PlayerBaseState newSubState)
    {
        _currentSubState = newSubState;
        newSubState.SetSuperState(this);
    }
}
