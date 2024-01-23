using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerManager : MonoBehaviour
{
    public GameObject hannah;
    public GameObject armin;
    public GameObject hannahCam;
    public GameObject arminCam;

    public GameObject entityBox;

    private PlayerController _hControl;
    private PlayerController _aControl;
    private int _currentCharacter = 0; // 0 = hannah, 1 = armin
    private PlayerController _controlling;

    public MyInput controls;

    private void Awake()
    {
        controls = new MyInput();

        controls.Player.Move.started += ctx => OnMove(ctx);
        controls.Player.Move.performed += ctx => OnMove(ctx);
        controls.Player.Move.canceled += ctx => OnMove(ctx);
        controls.Player.Jump.started += ctx => OnJump(ctx);
        controls.Player.Jump.canceled += ctx => OnJump(ctx);
        controls.Player.Switch.performed += _ => OnSwitch();
        controls.Player.Look.performed += ctx => OnLook();
        controls.Player.Duck.performed += ctx => OnDuck();
    }

    // Start is called before the first frame update
    void Start()
    {
        _hControl = hannah.GetComponent<PlayerController>();
        _aControl = armin.GetComponent<PlayerController>();

        _controlling = _hControl;
    }

    private void Update()
    {
        entityBox.transform.position = _controlling.transform.position;
        //DebugTileClick();
    }

    void OnSwitch()
    {
        // if the character we're controlling is in the air, don't switch
        if (!_controlling.Grounded)
            return;

        switch (_currentCharacter)
        {
            case 0:
                // switch to Armin
                _currentCharacter = 1;
                hannahCam.SetActive(false);
                arminCam.SetActive(true);
                _controlling = _aControl;
                break;
            case 1:
                // switch to Hannah
                _currentCharacter = 0;
                hannahCam.SetActive(true);
                arminCam.SetActive(false);
                _controlling = _hControl;
                break;
            default:
                break;
        }
    }

    private void OnEnable()
    {
        controls.Enable();
    }
    private void OnDisable()
    {
        controls.Disable();
    }

    void OnJump(InputAction.CallbackContext context)
    {
        //Debug.Log("Jump " + context.ReadValueAsButton());
        _controlling.JumpPressed = context.ReadValueAsButton();
        _controlling.RequireNewJumpPress = false;
    }

    void OnMove(InputAction.CallbackContext context)
    {
        //Debug.Log(move);
        _controlling.MoveDir = context.ReadValue<Vector2>();
        _controlling.MovePerformed = context.performed;
    }

    void OnLook()
    {

    }

    void OnDuck()
    {

    }

    void DebugTileClick()
    {
        if (Input.GetMouseButtonUp(0))
        {
            Vector2 mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            Vector3Int pos = MapManager.instance.GetEntityMap().WorldToCell(mousePos);
            Debug.Log("Tile " + pos + " at " + mousePos + " in world space");
        }
    }
}
