// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import SafeMath library
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

library ArrayUtils {
    using SafeMath for uint256;

    function quickSort(uint256[] memory data, int256 left, int256 right) internal pure {
        if (left < right) {
            int256 pivotIndex = partition(data, left, right);
            quickSort(data, left, pivotIndex - 1);
            quickSort(data, pivotIndex + 1, right);
        }
    }

    function partition(uint256[] memory data, int256 left, int256 right) internal pure returns (int256) {
        uint256 pivot = data[uint256(left + right) / 2];
        while (left < right) {
            while (data[uint256(left)] < pivot) left++;
            while (data[uint256(right)] > pivot) right--;
            if (left <= right) {
                (data[uint256(left)], data[uint256(right)]) = (data[uint256(right)], data[uint256(left)]);
                left++;
                right--;
            }
        }
        return left;
    }

    function sort(uint256[] memory data) internal pure {
        if (data.length > 1) {
            int256 left = int256(0);
            int256 right = int256(data.length - 1);
            quickSort(data, left, right);
        }
    }

    function removeDuplicates(uint256[] memory data) internal pure returns (uint256[] memory) {
        if (data.length <= 1) return data;

        uint256[] memory uniqueData = new uint256[](data.length);
        uint256 uniqueIndex = 0;

        for (uint256 i = 0; i < data.length; i++) {
            bool isDuplicate = false;
            for (uint256 j = 0; j < uniqueIndex; j++) {
                if (data[i] == uniqueData[j]) {
                    isDuplicate = true;
                    break;
                }
            }
            if (!isDuplicate) {
                uniqueData[uniqueIndex] = data[i];
                uniqueIndex++;
            }
        }

        uint256[] memory result = new uint256[](uniqueIndex);
        for (uint256 i = 0; i < uniqueIndex; i++) {
            result[i] = uniqueData[i];
        }

        return result;
    }
}

contract ArrayManipulationContract {
    using ArrayUtils for uint256[];

    uint256[] public dataArray;

    function addData(uint256[] memory newData) public {
        dataArray = newData;
    }

    function sortData() public view returns (uint256[] memory) {
    uint256[] memory sortedData = dataArray;
    sortedData.sort();
    return sortedData;
}


    function removeDuplicatesFromData() public {
        dataArray = dataArray.removeDuplicates();
    }

    function getData() public view returns (uint256[] memory) {
        return dataArray;
    }
}
