import 'package:universal_html/html.dart' as html;

void fnRegisterBeforeUnloadWarning({String? message}) {
  html.window.onBeforeUnload.listen((event) {
    final e = event as html.BeforeUnloadEvent;
    e.returnValue = message ??
        '변경 사항이 저장되지 않았습니다. 새로고침 하시겠습니까?'; // 커스텀 메시지는 무시됨 - 브라우저 기본 메시지만 보여줌
  });
}

/// 경고 제거 (필요 시 해제용)
void fnRemoveBeforeUnloadWarning() {
  html.window.onBeforeUnload.listen(null);
}