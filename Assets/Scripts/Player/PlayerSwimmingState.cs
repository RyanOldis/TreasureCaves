using UnityEngine;

public class PlayerSwimmingState : PlayerBaseState
{
    public PlayerSwimmingState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = true;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        
    }

    public override void EnterState()
    {
        
    }

    public override void ExitState()
    {
        
    }

    public override void InitializeSubstate()
    {
        
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        
    }

    public override void OnCollisionExit(Collision2D collision)
    {
        
    }

    public override void OnTriggerEnter(Collider2D collision)
    {
        
    }

    public override void OnTriggerExit(Collider2D collision)
    {
        
    }

    public override void UpdateState()
    {
        CheckSwitchState();
    }
}
