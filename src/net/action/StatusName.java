package net.action;

import java.util.HashMap;

public class StatusName {
    
    static HashMap<String, String> statusMap = new HashMap<String, String>();

    static
    {
        statusMap.put("prepare","�ݵ� �غ� �ۼ� ��");
        statusMap.put("prepareDetail", "�ʼ� �׸��� ��� �ۼ� �� �����ϱ� ��ư�� Ŭ�����ּ���. �ۼ� �� > �ۼ� �Ϸ� ���·� ����Ǿ�� ���� ������ �����մϴ�.");
        statusMap.put("submission", "�ݵ� ����");
        statusMap.put("submissionDetail", "������Ʈ�� �����Ͽ����ϴ�. ���� ����� ������ ������ ������ �� �����ϴ�.");
        statusMap.put("approve", "�ݵ� ����");
        statusMap.put("approveDetail", "�����Ͻ� ������Ʈ�� ���εǾ����ϴ�. ������ ���������� �غ����ּ���.");
        statusMap.put("reject", "�ݵ� �ݷ�");
        statusMap.put("rejectDetail", "�����Ͻ� ������Ʈ�� �ݷ��Ǿ����ϴ�. �ݷ� ������ �о�ñ� �ٶ��ϴ�.");
        //statusMap.put("apply", "�ݵ� ���� �� ��û �Ϸ�");
        //statusMap.put("applyDetail", "���ε� ������Ʈ�� ���� ��û�� �Ϸ�Ǿ����ϴ�. ������ ���� �����带 �ѹ� �� �������ּ���");
        statusMap.put("start", "�ݵ� ����");
        statusMap.put("startDetail", "�ݵ��� ����ǰ� �ֽ��ϴ�. �Ǹ� ��Ȳ �޴����� �Ǹ� ������ Ȯ���Ͻ� �� �ֽ��ϴ�.");
        statusMap.put("end", "�ݵ� ����");
        statusMap.put("endDetail", "�ݵ� �������Դϴ�. �Ǹ� ��Ȳ �޴����� �ݵ� ����� Ȯ���غ�����.");
        statusMap.put("success", "�ݵ� ����");
        statusMap.put("successDetail", "�ݵ��� ���������� �Ϸ�Ǿ����ϴ�. ���ϵ帳�ϴ�. ��۱��� �������� �����Ͻð� ������ ������Ȳ���� Ȯ�����ּ���.");
        statusMap.put("fail", "�ݵ� ����");
        statusMap.put("failDetail", "�ݵ��� ��Ÿ���Ե� �����Ͽ����ϴ�. �� �� ���� �ݵ��� ���� ����غ��ñ� �ٶ��ϴ�.");
    }

    public static String get(String key){
    	return statusMap.get(key);
   }

}
