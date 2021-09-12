/*     */ package net.funding.open.db;
/*     */ 
/*     */ import java.sql.Timestamp;
/*     */ 
/*     */ public class fundingorderBean
/*     */ {
/*     */   private String orderId;
/*     */   private String userId;
/*     */   private String receiver;
/*     */   private String receiverPhone;
/*     */   private String receiverEmail;
/*     */   private String zipCode;
/*     */   private String addr1;
/*     */   private String addr2;
/*     */   private String Requests;
/*     */   private String orderDate;
/*     */   private String cardNumber;
/*     */   private String ExpirationDate;
/*     */   private String birth;
			private int quantity;
/*     */   private int amount;
			private int salesQuantity;
			private int usePoint;
			private int fundingId;
			
			
			
			
public String getOrderDate() {
				return orderDate;
			}
			public void setOrderDate(String orderDate) {
				this.orderDate = orderDate;
			}
public int getQuantity() {
				return quantity;
			}
			public void setQuantity(int quantity) {
				this.quantity = quantity;
			}
public int getFundingId() {
				return fundingId;
			}
			public void setFundingId(int fundingId) {
				this.fundingId = fundingId;
			}
public int getUsePoint() {
				return usePoint;
			}
			public void setUsePoint(int usePoint) {
				this.usePoint = usePoint;
			}
public int getSalesQuantity() {
				return salesQuantity;
			}
			public void setSalesQuantity(int salesQuantity) {
				this.salesQuantity = salesQuantity;
			}
/*     */ 
/*     */  
/*     */   public String getOrderId() {
/*  30 */     return this.orderId;
/*     */   }
/*     */   public void setOrderId(String orderId) {
/*  33 */     this.orderId = orderId;
/*     */   }
/*     */   public String getUserId() {
/*  36 */     return this.userId;
/*     */   }
/*     */   public void setUserId(String userId) {
/*  39 */     this.userId = userId;
/*     */   }
/*     */   public String getReceiver() {
/*  42 */     return this.receiver;
/*     */   }
/*     */   public void setReceiver(String receiver) {
/*  45 */     this.receiver = receiver;
/*     */   }
/*     */   public String getReceiverPhone() {
/*  48 */     return this.receiverPhone;
/*     */   }
/*     */   public void setReceiverPhone(String receiverPhone) {
/*  51 */     this.receiverPhone = receiverPhone;
/*     */   }
/*     */   public String getReceiverEmail() {
/*  54 */     return this.receiverEmail;
/*     */   }
/*     */   public void setReceiverEmail(String receiverEmail) {
/*  57 */     this.receiverEmail = receiverEmail;
/*     */   }
/*     */   public String getZipCode() {
/*  60 */     return this.zipCode;
/*     */   }
/*     */   public void setZipCode(String zipCode) {
/*  63 */     this.zipCode = zipCode;
/*     */   }
/*     */   public String getAddr1() {
/*  66 */     return this.addr1;
/*     */   }
/*     */   public void setAddr1(String addr1) {
/*  69 */     this.addr1 = addr1;
/*     */   }
/*     */   public String getAddr2() {
/*  72 */     return this.addr2;
/*     */   }
/*     */   public void setAddr2(String addr2) {
/*  75 */     this.addr2 = addr2;
/*     */   }
/*     */   public String getRequests() {
/*  78 */     return this.Requests;
/*     */   }
/*     */   public void setRequests(String requests) {
/*  81 */     this.Requests = requests;
/*     */   }
/*     */ 
/*     */   public String getCardNumber() {
/*  85 */     return this.cardNumber;
/*     */   }
/*     */   public void setCardNumber(String cardNumber) {
/*  88 */     this.cardNumber = cardNumber;
/*     */   }
/*     */   public String getExpirationDate() {
/*  91 */     return this.ExpirationDate;
/*     */   }
/*     */   public void setExpirationDate(String expirationDate) {
/*  94 */     this.ExpirationDate = expirationDate;
/*     */   }
/*     */   public String getBirth() {
/*  97 */     return this.birth;
/*     */   }
/*     */   public void setBirth(String birth) {
/* 100 */     this.birth = birth;
/*     */   }
/*     */   public int getAmount() {
/* 103 */     return this.amount;
/*     */   }
/*     */   public void setAmount(int amount) {
/* 106 */     this.amount = amount;
/*     */   }
/*     */ }

/* Location:           C:\Users\ITWILL\Desktop\ImportedClasses\
 * Qualified Name:     net.funding.open.db.fundingorderBean
 * JD-Core Version:    0.6.2
 */