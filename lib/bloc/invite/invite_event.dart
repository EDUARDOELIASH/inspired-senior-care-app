part of 'invite_bloc.dart';

@immutable
abstract class InviteEvent extends Equatable {
  final Invite? invite;
  final String? emailAddress;
  final Group? group;
  const InviteEvent({
    this.invite,
    this.emailAddress,
    this.group,
  });
  @override
  List<Object?> get props => [invite];
}

class LoadInvites extends InviteEvent {}

class ManagerInviteSent extends InviteEvent {
  @override
  final String emailAddress;
  @override
  final Group group;
  const ManagerInviteSent({
    required this.emailAddress,
    required this.group,
  });
  @override
  List<Object?> get props => [emailAddress, group];
}

class MemberInviteSent extends InviteEvent {
  @override
  final String emailAddress;
  @override
  final Group group;
  const MemberInviteSent({
    required this.emailAddress,
    required this.group,
  });
  @override
  List<Object?> get props => [emailAddress, group];
}

class InviteReceived extends InviteEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InviteDeleted extends InviteEvent {
  @override
  final Invite invite;
  const InviteDeleted({
    required this.invite,
  });
  @override
  List<Object?> get props => [invite];
}

class InviteAccepted extends InviteEvent {
  @override
  Invite invite;
  InviteAccepted({
    required this.invite,
  });
  @override
  List<Object?> get props => [invite];
}

class InviteCancelled extends InviteEvent {
  @override
  Invite invite;
  InviteCancelled({
    required this.invite,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InviteDenied extends InviteEvent {
  @override
  Invite invite;
  InviteDenied({
    required this.invite,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
