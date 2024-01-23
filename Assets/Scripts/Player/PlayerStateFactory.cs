using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerStateFactory
{
    PlayerController _context;

    public PlayerStateFactory(PlayerController currentContext)
    {
        _context = currentContext;
    }

    public PlayerBaseState Ground()
    {
        return new PlayerGroundState(_context, this);
    }
    public PlayerBaseState Ladder()
    {
        return new PlayerLadderState(_context, this);
    }
    public PlayerBaseState IdleClimb()
    {
        return new PlayerIdleLadderState(_context, this);
    }
    public PlayerBaseState Climb()
    {
        return new PlayerClimbState(_context, this);
    }
    public PlayerBaseState Swimming()
    {
        return new PlayerSwimmingState(_context, this);
    }
    public PlayerBaseState Jump()
    {
        return new PlayerJumpState(_context, this);
    }

    public PlayerBaseState Idle()
    {
        return new PlayerIdleState(_context, this);
    }

    public PlayerBaseState Move()
    {
        return new PlayerMovingState(_context, this);
    }

    public PlayerBaseState Fall()
    {
        return new PlayerFallingState(_context, this);
    }

    public PlayerBaseState Coyote()
    {
        return new PlayerCoyoteState(_context, this);
    }
}
