/*

    Copyright 2020 dYdX Trading Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

*/

pragma solidity 0.5.16;
pragma experimental ABIEncoderV2;

import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


/**
 * @title SignedMath
 * @author dYdX
 *
 * SignedMath library for doing math with signed integers.
 */
library SignedMath {
    using SafeMath for uint256;

    // ============ Structs ============

    struct Int {
        uint256 value;
        bool isPositive;
    }

    // ============ Functions ============

    function add(
        Int memory sint,
        uint256 value
    )
        internal
        pure
        returns (Int memory)
    {
        if (sint.isPositive) {
            return Int({
                value: value.add(sint.value),
                isPositive: true
            });
        }
        if (sint.value < value) {
            return Int({
                value: value.sub(sint.value),
                isPositive: true
            });
        }
        return Int({
            value: sint.value.sub(value),
            isPositive: false
        });
    }

    function sub(
        Int memory sint,
        uint256 value
    )
        internal
        pure
        returns (Int memory)
    {
        if (!sint.isPositive) {
            return Int({
                value: value.add(sint.value),
                isPositive: false
            });
        }
        if (sint.value > value) {
            return Int({
                value: sint.value.sub(value),
                isPositive: true
            });
        }
        return Int({
            value: value.sub(sint.value),
            isPositive: false
        });
    }
}
