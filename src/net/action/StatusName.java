package net.action;

import java.util.HashMap;

public class StatusName {
    
    static HashMap<String, String> statusMap = new HashMap<String, String>();

    static
    {
        statusMap.put("prepare","펀딩 준비 작성 중");
        statusMap.put("prepareDetail", "필수 항목을 모두 작성 후 저장하기 버튼을 클릭해주세요. 작성 중 > 작성 완료 상태로 변경되어야 최종 제출이 가능합니다.");
        statusMap.put("submission", "펀딩 제출");
        statusMap.put("submissionDetail", "프로젝트를 제출하였습니다. 검토 결과가 나오기 전에는 수정할 수 없습니다.");
        statusMap.put("approve", "펀딩 승인");
        statusMap.put("approveDetail", "제출하신 프로젝트가 승인되었습니다. 오픈을 마지막까지 준비해주세요.");
        statusMap.put("reject", "펀딩 반려");
        statusMap.put("rejectDetail", "제출하신 프로젝트가 반려되었습니다. 반려 이유를 읽어보시길 바랍니다.");
        //statusMap.put("apply", "펀딩 승인 후 신청 완료");
        //statusMap.put("applyDetail", "승인된 프로젝트의 오픈 신청이 완료되었습니다. 오픈을 위해 리워드를 한번 더 검토해주세요");
        statusMap.put("start", "펀딩 시작");
        statusMap.put("startDetail", "펀딩이 진행되고 있습니다. 판매 현황 메뉴에서 판매 정보를 확인하실 수 있습니다.");
        statusMap.put("end", "펀딩 마감");
        statusMap.put("endDetail", "펀딩 종료일입니다. 판매 현황 메뉴에서 펀딩 결과를 확인해보세요.");
        statusMap.put("success", "펀딩 성공");
        statusMap.put("successDetail", "펀딩이 성공적으로 완료되었습니다. 축하드립니다. 배송까지 문제없이 진행하시고 매출은 결제현황에서 확인해주세요.");
        statusMap.put("fail", "펀딩 실패");
        statusMap.put("failDetail", "펀딩이 안타깝게도 실패하였습니다. 좀 더 나은 펀딩을 위해 고민해보시길 바랍니다.");
    }

    public static String get(String key){
    	return statusMap.get(key);
   }

}
