import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/repositories/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_service.g.dart';

class MemberService {
  MemberService(this._memberRepository);
  final MemberRepository _memberRepository;

  Stream<List<Member>> allMemberStream() => _memberRepository.watchMembers();
}

@riverpod
MemberService memberService(MemberServiceRef ref, String season) {
  return MemberService(ref.watch(memberRepositoryProvider(season)));
}

@riverpod
Stream<List<Member>> memberStream(MemberStreamRef ref, String season) {
  final memberService = ref.watch(memberServiceProvider(season));
  return memberService.allMemberStream();
}
