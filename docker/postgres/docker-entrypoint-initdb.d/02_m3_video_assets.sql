/*
Script generated by Aqua Data Studio 22.1.2 on Feb-26-2022 11:32:50 AM
Database: M3_VIDEO_ASSETS
Schema: dbo
Objects: TABLE, VIEW, INDEX
*/
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE video_sequences  ( 
	"uuid"             	uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
	"camera_id"        	varchar(256) NOT NULL,
	"description"      	varchar(2048) NULL,
	"name"             	varchar(512) NOT NULL,
	"last_updated_time"	timestamp NULL,
	UNIQUE("name"));

/* Postgresql foreign keys default to NO ACTION on delete or update */
CREATE TABLE videos  ( 
	"uuid"               	uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
	"video_sequence_uuid"	uuid NOT NULL,
	"description"        	varchar(2048) NULL,
	"duration_millis"    	numeric(19,0) NULL,
	"name"               	varchar(512) NOT NULL,
	"start_time"         	timestamp NOT NULL,	/* start_time is the start time of the video */	
	"last_updated_time"  	timestamp NULL,
	UNIQUE("name"),
	CONSTRAINT fk_videos__video_seqeunces 
	  FOREIGN KEY(video_sequence_uuid) 
		REFERENCES video_sequences("uuid"));

CREATE TABLE video_references  ( 
	"uuid"             	uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
	"video_uuid"       	uuid NOT NULL,
	"audio_codec"      	varchar(128) NULL,
	"container"        	varchar(128) NULL,
	"description"      	varchar(2048) NULL,
	"frame_rate"       	DOUBLE PRECISION NULL,
	"height"           	integer NULL,
	"sha512"           	varchar(128) NULL,
	"size_bytes"       	numeric(19,0) NULL,
	"uri"              	varchar(1024) NOT NULL,
	"video_codec"      	varchar(128) NULL,
	"width"            	integer NULL,
	"last_updated_time"	timestamp NULL,
	UNIQUE("uri"),
	CONSTRAINT fk_videos_references__videos
	  FOREIGN KEY(video_uuid) 
		REFERENCES videos("uuid"));

CREATE INDEX "idx_video_references__uri"
	ON "video_references"("uri");

CREATE INDEX "idx_video_references__video_uuid"
	ON "video_references"("video_uuid");

CREATE INDEX "idx_video_sequences__camera_id"
	ON "video_sequences"("camera_id");

CREATE INDEX "idx_video_sequences__name"
	ON "video_sequences"("name");

CREATE INDEX "idx_videos__name"
	ON "videos"("name");

CREATE INDEX "idx_videos__start_time"
	ON "videos"("start_time");

CREATE INDEX "idx_videos__video_sequence_uuid"
	ON "videos"("video_sequence_uuid");

CREATE VIEW "unique_videos"
AS 
SELECT 
  s.uuid AS video_sequence_uuid,
  s.name AS video_sequence_name,
  v.uuid AS video_uuid,
  v.name AS video_name,
  r.uuid AS video_reference_uuid,
  r.uri,
  s.camera_id,
  v.duration_millis,
  v.start_time,
  r.container,
  r.width,
  r.height,
  r.size_bytes,
  r.last_updated_time,
  r.sha512
FROM 
    video_sequences AS s LEFT JOIN
    videos AS v ON v.video_sequence_uuid = s.uuid LEFT JOIN
    video_references AS r ON r.video_uuid = v.uuid;


