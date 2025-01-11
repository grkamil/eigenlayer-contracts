// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.27;

import "@openzeppelin-upgrades/contracts/utils/structs/EnumerableSetUpgradeable.sol";

import "../interfaces/IPermissionController.sol";

abstract contract PermissionControllerStorage is IPermissionController {
    using EnumerableSetUpgradeable for EnumerableSetUpgradeable.Bytes32Set;
    using EnumerableSetUpgradeable for EnumerableSetUpgradeable.AddressSet;

    struct AccountPermissions {
        /// @notice The pending admins of the account
        EnumerableSetUpgradeable.AddressSet pendingAdmins;
        /// @notice The admins of the account
        EnumerableSetUpgradeable.AddressSet admins;
        /// @notice Mapping from an appointee to the list of encoded target & selectors
        mapping(address appointee => EnumerableSetUpgradeable.Bytes32Set) appointeePermissions;
        /// @notice Mapping from encoded target & selector to the list of appointees
        mapping(bytes32 targetSelector => EnumerableSetUpgradeable.AddressSet) permissionAppointees;
    }

    /// @notice Mapping from an account to its permission
    mapping(address account => AccountPermissions) internal _permissions;

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}
