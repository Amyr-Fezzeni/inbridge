enum Gender { male, female, other }
enum UserStatus { active, banned, disabled, deleted }
enum Role { creator, admin }
enum Category {post}
enum PostType {type}

UserStatus getUserStatusFromString(String? value) =>
    {
      'active': UserStatus.active,
      'banned': UserStatus.banned,
      'disabled': UserStatus.disabled,
      'deleted': UserStatus.deleted
    }[value] ??
    UserStatus.disabled;


Gender? getUserGenderFromString(String? value) => {
      'male': Gender.male,
      'female': Gender.female,
      'other': Gender.other
    }[value];


Role getUserRoleFromString(String? value) =>
    {
      'admin': Role.admin,
    }[value] ??
    Role.creator;