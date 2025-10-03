// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract ToDoList {

    enum State {
        Created,
        Completed
    }

    struct Task {
        string description;
        uint256 creationTime; 
        uint256 index;
        State state;
    }

    Task[] private task;
    uint256 private taskCount;

    error InvalidValue();

    event AddedTask(uint256 indexed index, string indexed description, uint256 creationTime);
    event TaskStatusChanged(uint256 indexed index, string indexed description, string indexed newStatus);
    event paid(address indexed payer, uint256 amount);

    mapping(address=>uint256) public balance; 

    function setTask(string calldata _description) external {
        uint256 _taskCount = taskCount; //Para ahorrar gas, podría haber sido taskCount++ ->
        task.push(Task(_description, block.timestamp, _taskCount, State.Created));
        ++_taskCount; //<-- eso no iría ->
        taskCount = _taskCount; //<- eso tampoco
        emit AddedTask(_taskCount, _description, block.timestamp);
    }

    function pay() external payable {
        if (msg.value != 0.1 ether) revert InvalidValue();
        balance[msg.sender] = msg.value;
        emit paid(msg.sender, msg.value);
    }

    function withdraw() external returns(bytes memory) {
        address to = msg.sender;
        uint256 myBalance = balance[msg.sender];
        balance[msg.sender] = 0;
        (bool success, bytes memory data)=to.call{value: myBalance}("");
        if(!success) revert();
        return data;
    }

    function withdraw2() external {
        address payable to = payable(msg.sender);
        uint256 myBalance = balance[msg.sender];
        balance[msg.sender] = 0;
        to.transfer(myBalance);
    }

    function withdraw3() external {
        address payable to = payable(msg.sender);
        uint256 myBalance = balance[msg.sender];
        balance[msg.sender] = 0;
        bool success = to.send(myBalance);
        if (!success) revert();
    }

    function getTask() external view returns (Task[] memory) {
        return task;
    }

    function deleteTask(string calldata _description) external {
        uint256 len = task.length;
        for(uint256 i; i<len;) {
            if(keccak256(bytes(task[i].description)) == keccak256(bytes(_description))) { //Casteamos la descriptción en bytes
                emit TaskStatusChanged(task[i].index, task[i].description, "eliminado");
                task[i] = task[len - 1]; //reemplazamos el elemento a borrar con el último
                task.pop(); //borramos el último elemento
                break;
            }
            unchecked {
                ++i;
            }
        }
    } 

    function completeTask(string calldata _description) external {
        uint256 len = task.length;
        for(uint256 i; i<len;) {
            if(keccak256(bytes(task[i].description)) == keccak256(bytes(_description))) { //Casteamos la descriptción en bytes
                emit TaskStatusChanged(task[i].index, task[i].description, "completado");
                task[i].state = State.Completed;
                break;
            }
            unchecked {
                ++i;
            }
        }
    } 

}