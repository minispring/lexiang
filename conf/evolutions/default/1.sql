# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table area (
  id                        bigint auto_increment not null,
  code                      varchar(255),
  name                      varchar(255),
  citycode                  varchar(255),
  constraint pk_area primary key (id))
;

create table city (
  id                        bigint auto_increment not null,
  code                      varchar(255),
  name                      varchar(255),
  provincecode              varchar(255),
  constraint pk_city primary key (id))
;

create table communities (
  id                        bigint auto_increment not null,
  logo                      varchar(255),
  name                      varchar(255),
  bio                       varchar(255),
  user_id                   bigint,
  constraint pk_communities primary key (id))
;

create table linked_account (
  id                        bigint auto_increment not null,
  user_id                   bigint,
  provider_user_id          varchar(255),
  provider_key              varchar(255),
  constraint pk_linked_account primary key (id))
;

create table profiles (
  id                        bigint auto_increment not null,
  birthday                  datetime,
  height                    integer,
  weight                    integer,
  skills                    varchar(255),
  bio                       varchar(255),
  user_id                   bigint,
  constraint pk_profiles primary key (id))
;

create table province (
  id                        bigint auto_increment not null,
  code                      varchar(255),
  name                      varchar(255),
  constraint pk_province primary key (id))
;

create table security_role (
  id                        bigint auto_increment not null,
  role_name                 varchar(255),
  constraint pk_security_role primary key (id))
;

create table tags (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  type                      varchar(255),
  constraint pk_tags primary key (id))
;

create table token_action (
  id                        bigint auto_increment not null,
  token                     varchar(255),
  target_user_id            bigint,
  type                      varchar(2),
  created                   datetime,
  expires                   datetime,
  constraint ck_token_action_type check (type in ('EV','PR')),
  constraint uq_token_action_token unique (token),
  constraint pk_token_action primary key (id))
;

create table users (
  id                        bigint auto_increment not null,
  email                     varchar(255),
  name                      varchar(255),
  first_name                varchar(255),
  last_name                 varchar(255),
  last_login                datetime,
  active                    tinyint(1) default 0,
  email_validated           tinyint(1) default 0,
  constraint pk_users primary key (id))
;

create table user_permission (
  id                        bigint auto_increment not null,
  value                     varchar(255),
  constraint pk_user_permission primary key (id))
;


create table communities_tags (
  communities_id                 bigint not null,
  tags_id                        bigint not null,
  constraint pk_communities_tags primary key (communities_id, tags_id))
;

create table users_security_role (
  users_id                       bigint not null,
  security_role_id               bigint not null,
  constraint pk_users_security_role primary key (users_id, security_role_id))
;

create table users_user_permission (
  users_id                       bigint not null,
  user_permission_id             bigint not null,
  constraint pk_users_user_permission primary key (users_id, user_permission_id))
;
alter table communities add constraint fk_communities_user_1 foreign key (user_id) references users (id) on delete restrict on update restrict;
create index ix_communities_user_1 on communities (user_id);
alter table linked_account add constraint fk_linked_account_user_2 foreign key (user_id) references users (id) on delete restrict on update restrict;
create index ix_linked_account_user_2 on linked_account (user_id);
alter table profiles add constraint fk_profiles_user_3 foreign key (user_id) references users (id) on delete restrict on update restrict;
create index ix_profiles_user_3 on profiles (user_id);
alter table token_action add constraint fk_token_action_targetUser_4 foreign key (target_user_id) references users (id) on delete restrict on update restrict;
create index ix_token_action_targetUser_4 on token_action (target_user_id);



alter table communities_tags add constraint fk_communities_tags_communities_01 foreign key (communities_id) references communities (id) on delete restrict on update restrict;

alter table communities_tags add constraint fk_communities_tags_tags_02 foreign key (tags_id) references tags (id) on delete restrict on update restrict;

alter table users_security_role add constraint fk_users_security_role_users_01 foreign key (users_id) references users (id) on delete restrict on update restrict;

alter table users_security_role add constraint fk_users_security_role_security_role_02 foreign key (security_role_id) references security_role (id) on delete restrict on update restrict;

alter table users_user_permission add constraint fk_users_user_permission_users_01 foreign key (users_id) references users (id) on delete restrict on update restrict;

alter table users_user_permission add constraint fk_users_user_permission_user_permission_02 foreign key (user_permission_id) references user_permission (id) on delete restrict on update restrict;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table area;

drop table city;

drop table communities;

drop table communities_tags;

drop table linked_account;

drop table profiles;

drop table province;

drop table security_role;

drop table tags;

drop table token_action;

drop table users;

drop table users_security_role;

drop table users_user_permission;

drop table user_permission;

SET FOREIGN_KEY_CHECKS=1;

