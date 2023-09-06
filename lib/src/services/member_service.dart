import 'package:attendant151/src/models/member.dart';
import 'package:attendant151/src/repositories/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_service.g.dart';

class MemberService {
  MemberService(this._memberRepository);
  final MemberRepository _memberRepository;

  Stream<List<Member>> allMemberStream() => _memberRepository.watchMembers();
}

@riverpod
MemberService memberService(MemberServiceRef ref) {
  return MemberService(ref.watch(memberRepositoryProvider));
}

@riverpod
Stream<List<Member>> memberStream(MemberStreamRef ref) {
  final memberService = ref.watch(memberServiceProvider);
  return memberService.allMemberStream();
}
