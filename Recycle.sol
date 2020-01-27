pragma solidity >=0.5.11;
import "./access-control/RBAC.sol"; /// We should use this for role based access. as specified in our docs
import "./Token.sol";

contract Reycle{
    
  
    uint public averageTimeToCollectPlastic = 2;
    uint public totalCollectedPlastic = 0;

    uint public minWeight = 0;
    Token public anaToken;

    // Constructor. Pass it the token you want this contract to work with
    constructor(Token _token) public {
        anaToken = _token;
    }
    bool public rightRole;
    RBACExtend roleHelper;


    struct CollectedPlastic{
        address collector;
        uint id;
        uint kg;
        uint dateCollected;
    }
    
    constructor() public {
        roleHelper = new RBACExtend();
    }

    event PlasticIsAccounted(
        address collector,
        uint collectedPlasticId,
        uint collectedPlasticKg,
        uint collectedPlasticDate,
        uint currentAvarageTimeToCollectPlastic
    );

    event MinWeightIsUpdated(
        uint oldMinWeight,
        uint minWeight,
        address byAddress
    );

    event AverageTimeToCollectPlasticIsUpdated(
        uint oldAverageTimeToCollectPlastic,
        uint newAverageTimeToCollectPlastic,
        address byAddress
    );

    modifier validPlasticWeight(uint _kg) {
        require(_kg > minWeight, "More plastic is required for minimum valid transaction.");
        _;
    }

    mapping(uint => address) public plasticToCollector;
    mapping(address => uint) collectorPlasticCount;
    mapping(address => CollectedPlastic[]) collectorToCollectedPlastic;

    function _sendAnaTokenToCollector(address _collector, uint _kg) private hasRecyclePlantRole {
        uint256 id = getRandom();
        uint dateCollected = now;
        collectorToCollectedPlastic[_collector].push( CollectedPlastic(_collector, id, _kg, dateCollected));
        plasticToCollector[id] = _collector;
        collectorPlasticCount[_collector] += _kg;

        // TODO
        // D: Delegate, doing the transaction for A, and paying for the gas.
        uint tokens = _convertKilogramsToAnatoken(_kg);
        Token.delegatedTransfer(
            Nonce,  // N: Nonce
            address(this), // A: Sender of the payment
            _collector, // B: Recipient of the payment
            tokens, // X: Amount of Token T sent from A to B
            Y, // Y: Fee paid in Token T, from A to D for the transaction
            V,
            R,
            S
        );
        emit PlasticIsAccounted(
            _collector,
            id,
            _kg,
            dateCollected,
            averageTimeToCollectPlastic
        );

    modifier hasCollectorRole { require(roleHelper.userHasRole("collector"), "User doesn't have this role"); _;}
    modifier hasRecyclePlantRole { require(roleHelper.userHasRole("recyclePlant"), "User doesn't have this role"); _;}
    modifier hasRootRole {require(roleHelper.userHasRole("ROOT"), "User doesn't have this role"); _;} //might not be needed

    /// mappings
    mapping(uint => address) public plasticToOwner;
    mapping(address => uint) ownerPlasticCount;
    
    /*
     * Example function on how to use the RBACExtend contract
    */
    function roleExampleFunction() public hasRootRole view returns(string memory){
        return "Has role";
    }
    
    function _roleExampleFunction() public payable  returns (string memory) {
        roleExampleFunction();
    }

    function sendAnaTokenToCollector(address collector, uint kg) public payable {
        _sendAnaTokenToCollector(collector, kg);
    }

    function getCollectedPlasticFromUser(address user) external hasCollectorRole view returns (uint) {
        //get all the collected plastic from a user
        return collectorPlasticCount[user];
    }

    function _convertKilogramsToAnatoken(uint _kg) private returns(uint anaTokensAmount) {
        return _kg * averageTimeToCollectPlastic;
    }

    function updateAverageTimeToCollectPlastic(uint newValueAverageTimeToCollectPlastic) public{
        uint oldAverageTimeToCollectPlastic = averageTimeToCollectPlastic;
        averageTimeToCollectPlastic = newValueAverageTimeToCollectPlastic;
        emit AverageTimeToCollectPlasticIsUpdated(oldAverageTimeToCollectPlastic, averageTimeToCollectPlastic, msg.sender);
    }

    function updateMinWeight(uint newMinWeight) public{
        uint oldMinWeight = minWeight;
        minWeight = newMinWeight;
        emit MinWeightIsUpdated(oldMinWeight, minWeight, msg.sender);
    }

     function getRandom() private view returns(uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.coinbase, block.timestamp)));
    }
}

