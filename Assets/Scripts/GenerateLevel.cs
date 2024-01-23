using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;
using System.Threading;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

public class GenerateLevel : MonoBehaviour
{
    private Dictionary<char, tileTracker> _tileCollection;
    private RuleTile _terrain;
    private int _mapSizeY;

    [Header("Tilemaps")]
    public Tilemap tilemap;
    public Tilemap ladders;
    public Tilemap platforms;
    public Tilemap entities;
    public Tilemap spikes;
    public Tilemap waterTiles;

    [Header("Important Objects")]
    public GameObject hannah;
    public GameObject armin;
    public GameObject door;

    //private string level = "Untitled\nterrain 2\nbackground 1\nwater clear\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxwwxx  xxxxw  xxxxxxxxxxxxxxxxxxxxxxxxx\nxw  xxmxxxxw   xxxxxxxxxxxxxxxxxxxxxxxxx\nx    xxxxxx  xxxwwxxxx  wwxxxxxxxxxxxxxx\nxm  mxxxxw   xww             xxxxxxxxxxx\nxx  xxxw    xx                xxxxxxxxxx\nxxmmxxw   xxxw                xxxxxxxxxx\nxxxxxx ' xxw        ++ A    o  xxxxxxxxx\nxxxxxx            xxx====\"===   xxxxxxxx\nxxxxxx|          xxxx    \"      xxxxxxxx\nxxxxxx|          xxxw    \"      wxxxxxxx\nxxxxxxx  /      xxxx     \"       xxxxxxx\nxxxxxxx======   xxxx     \"        xxxxxx\nxxxxxxx         xxxw     \"         xxxxx\nxxxxxxw        xxxx      \"         xxxxx\nxxxxxx     ++ xxxxx      \"      +  xxxxx\nxxxxxx     ++xxxxxx {    \"   ======xxxxx\nxxxxxx     xxxxxxxx      \"         xxxxx\nxxxww     xxxxxw         \"         xxxxx\nxxx      xxxxx      ^    \"      ===xxxxx\nxxx    ==xx              \"         xxxxx\nxxx                      \"          xxxx\nxxx    #                 \"          xxxx\nxxxxmmxxxxx     \"=====   \"   =======xxxx\nxxxxxxxxxxxx    \"        \"           xxx\nxxxxxxxxxxxxxx  \"        \"           xxx\nxxxxxxxxxxxxxxxx\"     k  \"      =====xxx\nxxx             \"     b  \"           xxx\nxx+++           \"        \"           xxx\nxx+++           \"  b     \"     xxxxxxxxx\nxx+++           \" bbb    \"   xxxwwxxxxxx\nxxxxxxx        xxxxxxx   xxxxxx   wxxxxx\nxxxxxxxx      xxxxxxxxxxxxxxxx     xxxxx\nxxxxxxxxx      xxxxx                xxxx\nxxxxxxxxxxx                         xxxx\nxxxxxxxxxxxxx                   D   xxxx\nxxxxxxxxxxxxxx          xxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    //TextAsset file;
    //string level;
    System.Collections.Specialized.StringCollection data;
    string levelName;
    string terrainType;
    string background;
    string water;

    private Vector2Int _globalWaterLevel;
    private List<Vector2Int> _localWaterPockets;

    bool hasPlayer = false;
    bool hasDoor = false;

    // Start is called before the first frame update
    async void Start()
    {
        data = new System.Collections.Specialized.StringCollection();
        _tileCollection = new Dictionary<char, tileTracker>();
        _localWaterPockets = new List<Vector2Int>();
        LoadFileData();

        tilemap.ClearAllTiles();
        ladders.ClearAllTiles();
        platforms.ClearAllTiles();
        entities.ClearAllTiles();

        terrainType = "terrain 1";
        _terrain = Resources.Load<RuleTile>("Tiles/" + terrainType + "/Terrain") as RuleTile;
        //Debug.Log("Tiles/" + terrainType + "/Terrain");
        //Debug.Log(_terrain);
        //tilemap.GetComponent<Renderer>.setT
        BuildTileSet("Tiles/Pirate");

        await BuildLevel();        
        
    }

    void LoadFileData()
    {
        TextAsset file = Resources.Load<TextAsset>("Levels/Pirate/BoulderTest2") as TextAsset;
        string level = file.text;

        data.AddRange(level.Split('\n'));

        levelName = data[0];
        terrainType = data[1];
        background = data[2];
        water = data[3];
    }

    async Task BuildLevel()
    {

        //Debug.Log("Tiles/" + terrainType + "/Terrain");
        //terrain = Resources.Load<RuleTile>("Tiles/" + terrainType + "/Terrain") as RuleTile;

        for (int i = 4; i < data.Count - 1; i++)
        {
            for (int j = 0; j < data[i].Length - 1; j++)
            {
                switch (data[i][j])
                {
                    case ' ': // air
                        break;
                    case 'D': // door
                        Vector2 doorPos = tilemap.LocalToWorld(new Vector3(j, -i, 0));
                        door.transform.position = doorPos;
                        hasDoor = true;
                        break;
                    case '#': // Hannah
                        Vector2 playerPos1 = tilemap.LocalToWorld(new Vector3(j, -i + 1.1f, 0));
                        hannah.transform.position = playerPos1;
                        hasPlayer = true;
                        break;
                    case 'A': // Armin
                        Vector2 playerPos2 = tilemap.LocalToWorld(new Vector3(j, -i + 1.1f, 0));
                        armin.transform.position = playerPos2;
                        hasPlayer = true;
                        break;
                    case '~':
                        _globalWaterLevel = new Vector2Int(j, -i);
                        break;
                    case '-':
                        _localWaterPockets.Add(new Vector2Int(j, -i));
                        break;
                    case '0': // 1-5 are enemies if gamerule allows it, otherwise numbers are tutorial zones
                        break;
                    case '1':
                        break;
                    case '2':
                        break;
                    case '3':
                        break;
                    case '4':
                        break;
                    case '5':
                        break;
                    case '6':
                        break;
                    case '7':
                        break;
                    case '8':
                        break;
                    case '9':
                        break;
                    case '?':
                        _mapSizeY = i - 4;
                        return;
                    case '$':
                        _mapSizeY = i - 4;
                        return;
                    default:
                        _tileCollection[data[i][j]].map.SetTile(new Vector3Int(j, -i, 0), _tileCollection[data[i][j]].tile);
                        break;
                }
            }
        }

        await Task.Yield();
    }

    private void BuildTileSet(string filepath)
    {
        _tileCollection.Add('x', new tileTracker(_terrain, tilemap));
        _tileCollection.Add('z', new tileTracker(Resources.Load<Tile>("Tiles/Secret") as TileBase, tilemap));
        _tileCollection.Add('o', new tileTracker(Resources.Load<Tile>(filepath + "/Boulder") as TileBase, entities));
        _tileCollection.Add('b', new tileTracker(Resources.Load<Tile>(filepath + "/Box") as TileBase, entities));
        _tileCollection.Add('k', new tileTracker(Resources.Load<Tile>(filepath + "/SteelCrate") as TileBase, entities));
        _tileCollection.Add('^', new tileTracker(Resources.Load<Tile>(filepath + "/ArrowUp") as TileBase, entities));
        _tileCollection.Add('<', new tileTracker(Resources.Load<Tile>(filepath + "/ArrowLeft") as TileBase, entities));
        _tileCollection.Add('V', new tileTracker(Resources.Load<Tile>(filepath + "/ArrowDown") as TileBase, entities));
        _tileCollection.Add('>', new tileTracker(Resources.Load<Tile>(filepath + "/ArrowRight") as TileBase, entities));
        _tileCollection.Add('\'', new tileTracker(Resources.Load<Tile>(filepath + "/SteelArrowUp") as TileBase, entities));
        _tileCollection.Add('{', new tileTracker(Resources.Load<Tile>(filepath + "/SteelArrowLeft") as TileBase, entities));
        _tileCollection.Add(',', new tileTracker(Resources.Load<Tile>(filepath + "/SteelArrowDown") as TileBase, entities));
        _tileCollection.Add('}', new tileTracker(Resources.Load<Tile>(filepath + "/SteelArrowRight") as TileBase, entities));
        _tileCollection.Add('/', new tileTracker(Resources.Load<Tile>(filepath + "/BoxDynamite") as TileBase, entities));
        _tileCollection.Add('|', new tileTracker(Resources.Load<Tile>(filepath + "/SteelDynamite") as TileBase, entities));
        _tileCollection.Add('+', new tileTracker(Resources.Load<Tile>(filepath + "/Treasure") as TileBase, entities));
        _tileCollection.Add('L', new tileTracker(Resources.Load<Tile>(filepath + "/1up") as TileBase, entities));
        _tileCollection.Add('G', new tileTracker(Resources.Load<Tile>(filepath + "/Gem") as TileBase, entities));
        _tileCollection.Add('[', new tileTracker(Resources.Load<Tile>(filepath + "/Platform") as TileBase, platforms));
        _tileCollection.Add('=', new tileTracker(Resources.Load<Tile>(filepath + "/Platform") as TileBase, platforms));
        _tileCollection.Add(']', new tileTracker(Resources.Load<Tile>(filepath + "/Platform") as TileBase, platforms));
        _tileCollection.Add('\"', new tileTracker(Resources.Load<Tile>(filepath + "/Ladder") as TileBase, ladders));
        _tileCollection.Add('w', new tileTracker(Resources.Load<Tile>(filepath + "/Stalactites") as TileBase, spikes));
        _tileCollection.Add('m', new tileTracker(Resources.Load<Tile>(filepath + "/Stalagmites") as TileBase, spikes));
        _tileCollection.Add('s', new tileTracker(Resources.Load<Tile>(filepath + "/Snow") as TileBase, entities));
        _tileCollection.Add('n', new tileTracker(Resources.Load<Tile>(filepath + "/TutorialArrowUp") as TileBase, tilemap));
        _tileCollection.Add('(', new tileTracker(Resources.Load<Tile>(filepath + "/TutorialArrowLeft") as TileBase, tilemap));
        _tileCollection.Add('u', new tileTracker(Resources.Load<Tile>(filepath + "/TutorialArrowDown") as TileBase, tilemap));
        _tileCollection.Add(')', new tileTracker(Resources.Load<Tile>(filepath + "/TutorialArrowRight") as TileBase, tilemap));
    }

    int GetNumberFromString(string str)
    {
        string result = Regex.Match(str, @"\d").Value;
        // extract the int from the string
        return System.Int32.Parse(result);
    }

    int GetGameNumber(string str)
    {
        // string should be "terrain n"
        int terrain = GetNumberFromString(str);

        if (terrain > 4 && terrain < 8)
        {
            return 2;
        } else if (terrain > 7)
        {
            return 3;
        }

        return 1;
    }

    void AddWater()
    {
        //waterTiles.BoxFill()
    }

    struct tileTracker
    {
        public TileBase tile;
        public Tilemap map;
        public tileTracker(TileBase tl, Tilemap tm)
        {
            tile = tl;
            map = tm;
        }
    }
}
