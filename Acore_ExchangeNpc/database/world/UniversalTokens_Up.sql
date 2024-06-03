# Use this to make all tokens classless and not level restricted to avoid confused players.

UPDATE `item_template` SET `AllowableClass` = 2047, `ItemLevel` = 60, `RequiredLevel` = 60 WHERE `entry` IN (34858, 34853, 34852, 34855, 31096, 31102, 31090, 31093, 31099);
