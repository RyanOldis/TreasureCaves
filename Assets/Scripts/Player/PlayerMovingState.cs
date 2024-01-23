using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovingState : PlayerBaseState
{
    private static float _accelerationPotential = 0f;
    public static float AccelerationPotential { get { return _accelerationPotential; } set { _accelerationPotential = value; } }

    public PlayerMovingState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = false;
        InitializeSubstate();

        //_accelerationPotential = 0f;
    }

    public override void CheckSwitchState()
    {
        if (!_context.MovePerformed)
        {
            _context.PreviousMotion = new Vector3(_context.MotionX, _context.MotionY, _context.MotionZ);
            SwitchState(_factory.Idle());
        }
    }

    public override void EnterState()
    {
        //Debug.Log("moving");
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
        _accelerationPotential = Mathf.Lerp(_accelerationPotential, 1f, _context.accelerationRate * Time.deltaTime);
        _context.MotionX = _context.MoveDir.x * _context.speed * _accelerationPotential;
    }
}
