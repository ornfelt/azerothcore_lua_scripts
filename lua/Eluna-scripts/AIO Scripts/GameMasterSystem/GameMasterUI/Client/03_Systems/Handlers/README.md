# Handler Modules Structure

This directory contains the modularized handler components split from the original GMClient_08_Handlers.lua file.

## Module Organization

1. **DataReceiveHandlers.lua** (~400 lines)
   - All receive*Data handlers for items, NPCs, spells, etc.
   - Pagination and data management

2. **DialogHandlers.lua** (~600 lines)
   - ShowGiveGoldDialog
   - ShowBanDialog
   - Buff/spell related dialogs

3. **MailHandlers.lua** (~400 lines)
   - OpenMailDialog and all mail-related functionality
   - Mail composition and sending

4. **ErrorHandlers.lua** (~100 lines)
   - Error handling functions
   - Pagination error handlers

5. **CoreHandlers.lua** (~250 lines)
   - Core system handlers
   - Capability handlers
   - Test functions
   - Registration and finalization

## Load Order
Files are loaded alphabetically by AIO, so the naming ensures proper load order.