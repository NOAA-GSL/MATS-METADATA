CREATE PRIMARY INDEX `#primary` ON `vxdata`.`_default`.`METAR`
CREATE PRIMARY INDEX `#primary` ON `vxdatatest`.`_default`.`METAR` WITH {  "defer_build":true }
CREATE PRIMARY INDEX `#primary` ON `vxdata`.`_default`.`SCORECARD` WITH {  "defer_build":true }
CREATE PRIMARY INDEX `#primary` ON `vxdata`.`_default`.`SCORECARD_SETTINGS` WITH {  "defer_build":true }
CREATE PRIMARY INDEX `#primary` ON `vxdatatest` WITH {  "defer_build":true }
CREATE PRIMARY INDEX `#primary` ON `metplusdata`.`_system`.`_query`
CREATE PRIMARY INDEX `#primary` ON `vxdata`.`_system`.`_query` WITH {  "defer_build":true }
CREATE PRIMARY INDEX `#primary` ON `vxdata_dev`.`_system`.`_query`
CREATE PRIMARY INDEX `#primary` ON `vxdatatest`.`_system`.`_query` WITH {  "defer_build":true }
CREATE INDEX `adv_ceil_meta_cas_div_1000000000_meta_id` ON `vxdata`.`_default`.`METAR`(ceil(((meta().`cas`) / 1000000000)),(meta().`id`)) WITH {  "defer_build":true }
CREATE INDEX `adv_ceil_meta_cas_div_1000000000_meta_id` ON `vxdatatest`.`_default`.`METAR`(ceil(((meta().`cas`) / 1000000000)),(meta().`id`)) WITH {  "defer_build":true }
CREATE INDEX `adv_docType_fcstValidEpoch_type_version_subset` ON `vxdata`.`_default`.`METAR`(`docType`,`fcstValidEpoch`) WHERE (((`type` = "DD") and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_docType_fcstValidEpoch_type_version_subset` ON `vxdatatest`.`_default`.`METAR`(`docType`,`fcstValidEpoch`) WHERE (((`type` = "DD") and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_docType_subDocType_model_region_fcstLen` ON `vxdata`.`_default`.`METAR`(`docType`,`subDocType`,`model`,`region`,`fcstLen`,`fcstValidEpoch`) WHERE (((`subset` = "METAR") and (`version` = "V01")) and (`type` = "DD")) WITH {  "defer_build":true }
CREATE INDEX `adv_docType_subDocType_type_version` ON `vxdata`.`_default`.`METAR`(`docType`,`subDocType`) WHERE ((`type` = "DD") and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_docType_version_type_subset` ON `vxdata`.`_default`.`RAOB`(`docType`,`version`) WHERE ((`type` = "MD") and (`subset` = "RAOB")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstLen_model_fcstValidEpoch_type_docType_version` ON `vxdata`.`_default`.`METAR`(`fcstLen`,`model`,`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "model")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstLen_model_fcstValidEpoch_type_docType_version` ON `vxdatatest`.`_default`.`METAR`(`fcstLen`,`model`,`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "model")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstLen_model_fcstValidEpoch_type_docType_version_subset` ON `vxdata`.`_default`.`METAR`(`fcstLen`,`model`,`fcstValidEpoch`) WHERE ((((`type` = "DD") and (`docType` = "model")) and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstLen_model_fcstValidEpoch_type_docType_version_subset` ON `vxdatatest`.`_default`.`METAR`(`fcstLen`,`model`,`fcstValidEpoch`) WHERE ((((`type` = "DD") and (`docType` = "model")) and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstValidEpoch_fcstValidEpoch_sub_fcstLen_multi_3600_mod_24_3169354503` ON `vxdata`.`_default`.`METAR`(`fcstValidEpoch`,(`fcstValidEpoch` - (((`fcstLen` * 3600) % (24 * 3600)) / 3600)),`fcstLen`) WHERE ((((`docType` = "model") and (`model` = "HRRR_OPS")) and (`version` = "V01")) and (`type` = "DD")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstValidEpoch_region_type_docType_subDocType_version_subset` ON `vxdata`.`_default`.`METAR`(`fcstValidEpoch`,`region`) WHERE (((((`docType` = "SUMS") and (`subDocType` = "SURFACE")) and (`version` = "V01")) and (`subset` = "METAR")) and (`type` = "DD")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstValidEpoch_type_docType_version` ON `vxdata`.`_default`.`METAR`(`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "obs")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstValidEpoch_version_type_docType` ON `vxdata`.`_default`.`METAR`(`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "obs")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_fcstValidEpoch_version_type_docType` ON `vxdatatest`.`_default`.`METAR`(`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "obs")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_fileType_originType_subset_type_url_mtime` ON `vxdata`.`_default`.`RAOB`(`fileType`,`originType`,`url`,`mtime`) WHERE ((`subset` = "RAOB") and (`type` = "DF")) WITH {  "defer_build":true }
CREATE INDEX `adv_meta_cas_div_1000000000_meta_id_type` ON `vxdata`.`_default`.`METAR`(((meta().`cas`) / 1000000000),(meta().`id`)) WHERE (`type` = "DD") WITH {  "defer_build":true }
CREATE INDEX `adv_model_docType_fcstValidEpoch_type_version_subset_fcstLen` ON `vxdata`.`_default`.`METAR`(`model`,`docType`,`fcstValidEpoch`,`fcstLen`) WHERE (((`type` = "DD") and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_model_docType_fcstValidEpoch_type_version_subset_fcstLen` ON `vxdatatest`.`_default`.`METAR`(`model`,`docType`,`fcstValidEpoch`,`fcstLen`) WHERE (((`type` = "DD") and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_model_docType_subDocType_type_version_object_names_data` ON `vxdata`.`_default`.`METAR`(`model`,`docType`,`subDocType`,object_names(`data`)) WHERE ((`type` = "DD") and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_model_fcstLen_docType_fcstValidEpoch_type_version` ON `vxdata`.`_default`.`METAR`(`model`,`fcstLen`,`docType`,`fcstValidEpoch`) WHERE ((`type` = "DD") and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_model_fcstValidEpoch_docType_version_type` ON `vxdata`.`_default`.`METAR`(`model`,`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "model")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_model_fcstValidEpoch_docType_version_type` ON `vxdatatest`.`_default`.`METAR`(`model`,`fcstValidEpoch`) WHERE (((`type` = "DD") and (`docType` = "model")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_originType_model_subset_fileType_type_url_mtime` ON `vxdata`.`_default`.`METAR`(`originType`,`model`,`subset`,`fileType`,`type`,`url`,`mtime`) WITH {  "defer_build":true }
CREATE INDEX `adv_originType_model_subset_fileType_type_url_mtime` ON `vxdatatest`.`_default`.`METAR`(`originType`,`model`,`subset`,`fileType`,`type`,`url`,`mtime`) WITH {  "defer_build":true }
CREATE INDEX `adv_originType_model_subset_fileType_type_url_mtime_0` ON `vxdata`.`_default`.`METAR`(`originType`,`subset`,`fileType`,`type`,`url`,`mtime`) WITH {  "defer_build":true }
CREATE INDEX `adv_region_model_subset_version_type_docType_fcstValidISO_fcstValidEpoch` ON `vxdata`.`_default`.`METAR`(`region`,`model`,`fcstValidISO`,`fcstValidEpoch`) WHERE ((((`type` = "DD") and (`docType` = "CTC")) and (`subset` = "METAR")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_region_model_subset_version_type_docType_fcstValidISO_fcstValidEpoch` ON `vxdatatest`.`_default`.`METAR`(`region`,`model`,`fcstValidISO`,`fcstValidEpoch`) WHERE ((((`type` = "DD") and (`docType` = "CTC")) and (`subset` = "METAR")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_docType_model_version_type_object_names_data` ON `vxdata`.`_default`.`METAR`(`subDocType`,`docType`,`model`,object_names(`data`)) WHERE ((`type` = "DD") and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_fcstValidEpoch_region_model_fcstLen_type_docType_version_subset` ON `vxdata`.`_default`.`METAR`(`subDocType`,`fcstValidEpoch`,`region`,`model`,`fcstLen`) WHERE ((((`type` = "DD") and (`docType` = "CTC")) and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_fcstValidEpoch_region_model_fcstLen_type_docType_version_subset` ON `vxdatatest`.`_default`.`METAR`(`subDocType`,`fcstValidEpoch`,`region`,`model`,`fcstLen`) WHERE ((((`type` = "DD") and (`docType` = "CTC")) and (`version` = "V01")) and (`subset` = "METAR")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_model_docType_type_version` ON `vxdata`.`_default`.`METAR`(`subDocType`,`model`,`docType`) WHERE ((`type` = "DD") and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_type_docType_version` ON `vxdata`.`_default`.`METAR`(`subDocType`) WHERE (((`docType` = "CTC") and (`version` = "V01")) and (`type` = "DD")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_type_docType_version_model` ON `vxdata`.`_default`.`METAR`(`subDocType`,`model`) WHERE (((`type` = "DD") and (`docType` = "CTC")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_subDocType_version_type_docType_model` ON `vxdata`.`_default`.`METAR`(`subDocType`,`model`) WHERE (((`type` = "DD") and (`docType` = "CTC")) and (`version` = "V01")) WITH {  "defer_build":true }
CREATE INDEX `adv_type_id_status` ON `vxdata`.`_default`.`METAR`(`type`,`id`,`status`) WITH {  "defer_build":true }
CREATE INDEX `adv_type_subset_docType_version` ON `vxdata`.`_default`.`METAR`(`type`,`subset`,`docType`,`version`) WITH {  "defer_build":true }
CREATE INDEX `adv_type_subset_docType_version` ON `vxdatatest`.`_default`.`METAR`(`type`,`subset`,`docType`,`version`) WITH {  "defer_build":true }
CREATE INDEX `adv_version_docType_subset_type_geo_name` ON `vxdata`.`_default`.`METAR`(`version`,`docType`,`subset`,`type`,`geo`,`name`) WITH {  "defer_build":true }
CREATE INDEX `adv_version_docType_subset_type_geo_name` ON `vxdatatest`.`_default`.`METAR`(`version`,`docType`,`subset`,`type`,`geo`,`name`) WITH {  "defer_build":true }
CREATE INDEX `adv_version_fcstValidEpoch_type_docType_subset` ON `vxdata`.`_default`.`METAR`(`version`,`fcstValidEpoch`) WHERE (((`subset` = "METAR") and (`type` = "DD")) and (`docType` = "obs")) WITH {  "defer_build":true }
CREATE INDEX `adv_version_fcstValidEpoch_type_docType_subset` ON `vxdatatest`.`_default`.`METAR`(`version`,`fcstValidEpoch`) WHERE (((`subset` = "METAR") and (`type` = "DD")) and (`docType` = "obs")) WITH {  "defer_build":true }
CREATE PRIMARY INDEX `idx_default_primary` ON `vxdata`.`_default`.`RAOB` WITH {  "defer_build":true }
