# Java Report 与当前项目不一致修改清单

对比对象：
- 旧报告：`Java Report.docx`
- 当前项目：`FoodOrderingSystem` 当前 JSP、Servlet、CSS、JS、SQL 文件
- 当前状态重点：品牌已改为 `MellowBite`，整体 UI 已改为深色黑金 premium dining 风格，`Popular Choices` 已改用 promotion 卡片样式，`promotions.jsp` 和 `/promotions` 路由已删除。

## 1. 全局必须修改

| 类型 | 旧报告/旧截图内容 | 当前项目实际情况 | 必须修改 |
|---|---|---|---|
| 品牌名称 | 多处显示 `Food Ordering` | 页面 header/footer/title 已改为 `MellowBite` | 报告全文、所有截图、图注中的品牌都要改为 `MellowBite` |
| 网站定位 | 报告和旧截图偏向 `campus delivery`、普通 fast food ordering | 当前首页文案是 `Premium dining, delivered warm`、`Elegant restaurant favorites`、`MellowBite - Premium Dining` | Introduction、Homepage 描述、footer 描述、About 描述都要改成 premium dining/restaurant ordering |
| 视觉风格 | 浅黄色背景、棕色标题、旧按钮样式 | 深色黑金背景、glass/card 视觉、金色按钮、reveal 动画 | 所有 Page Screenshot 都要重截；报告文字中不要再描述旧浅色风格 |
| Footer 信息 | `XMUM Campus Restaurant`、`support@foodordering.test`、`Campus meals...` | `MellowBite Restaurant`、`support@mellowbite.test`、`Premium dining favorites...` | 所有页面截图和文字说明都要替换 |
| 左右广告 | 旧 CSS 曾有页面左右固定广告/侧边促销条 | 当前 CSS 已删除 `body::before/body::after` 广告伪元素 | 截图中不能出现左右广告；报告不要描述 side advertisement |
| Promotions 页面 | 旧项目曾有 `promotions.jsp`/`/promotions` | 当前已删除 JSP 和路由 | 报告中不能新增 Promotions 页面说明；如已有相关截图/目录说明必须删除 |

## 2. 报告文字需要修改

### 2.1 Introduction

需要改：
- `The Food Ordering and Restaurant Management Website...` 应改为 `MellowBite Food Ordering and Restaurant Management Website...`。
- “customer-facing ordering flow with a restaurant-facing management interface” 仍正确，但要补充当前项目的 premium dining positioning、black-and-gold UI、featured specials、popular choices promo card layout。
- “Customers can browse featured and popular dishes...” 仍正确，但 `Popular Choices` 现在不是普通 food card，而是复用 promotion card 样式。
- 如果报告文字中出现 `Food Ordering System`，建议统一改成 `MellowBite Food Ordering System`。

建议替换文字：

```md
The MellowBite Food Ordering and Restaurant Management Website is a Java EE web application for premium restaurant ordering. It supports customer menu browsing, food detail viewing, registration and login, cart management, checkout, order history, and administrator management of foods, categories, and customer orders.

The current interface uses a black-and-gold premium dining style. The homepage presents featured dishes, promotion-style Popular Choices cards, chef recommendations, About, FAQ, and Contact sections.
```

### 2.2 System Architecture Design

当前报告基本正确，但需要补充：
- `StaticPageServlet` 目前只处理 `/about`、`/faq`、`/contact`，不再处理 `/promotions`。
- `AdminFoodServlet` 现在使用 `@MultipartConfig` 和 `Part` 支持本地图片上传。
- `AdminFoodServlet` 现在只保留 Add/Edit/Delete 三种食物管理动作，不再提供 Disable 操作。
- `AdminCategoryServlet` 现在也应描述为 Add/Edit/Delete 三种分类管理动作，不再描述 Disable。
- 前端 JS 不只是表单验证，还包含 `IntersectionObserver` reveal 动画和 contact fake submit。

需要删除或避免：
- 不要写 `/promotions` 由 `StaticPageServlet` 转发。

### 2.3 Key Interaction Flow

报告中客户下单流程大体正确，但要明确当前实际逻辑：
- `CartServlet.doPost()` 一开始就调用 `requireLogin`，所以用户从菜单点 `Add to Cart` 时如果未登录，会立即跳转登录页，不是等到 checkout 才检查。
- 菜单页快速 `Add to Cart` 固定 `quantity=1`，不选择 add-ons。
- add-ons 只在 `food-detail.jsp` 选择：`Extra Cheese`、`Drink`、`Large Portion`。
- checkout 成功后实际转发到 `orderSuccess.jsp`，不是直接使用 `order-confirmation.jsp`。当前两个 JSP 内容相同，但流程用的是 `orderSuccess.jsp`。
- contact form 不提交到后台，只调用 `fakeContactSubmit(event)`，弹出感谢提示并 reset 表单。

管理员流程需要补充：
- Food Management 现在支持 `Edit`。
- Food Management 支持上传 `Food Image` 文件，也支持 `Image URL`。
- Food Management 现在只有 `Add`、`Edit`、`Delete` 三类操作；`Delete` 会先确认，若该 food 被已有订单引用，则提示无法删除。
- Category Management 现在也只有 `Add`、`Edit`、`Delete` 三类操作；若分类仍被 food 引用，则删除失败并提示原因。
- Order Management 仍支持 `Complete` 和 `Cancel`。

### 2.4 Database Design

报告中数据库 schema 描述基本匹配，但需要改数据规模和细节：
- seed 数据当前有 `30` 个 foods，不是截图中的 `6` 个 foods。
- categories 仍是 4 个：`Main Course`、`Snack`、`Drink`、`Dessert`。
- users 仍有 demo admin/customer。
- foods 表仍有 `featured` 和 `popular` 字段。
- orders 表包含 `completed_time`。
- users 表中的 password 存储的是 hash，不应描述成明文 password。
- order_items 仍保存快照字段：`food_name`、`unit_price`、`addons`、`addon_price`、`subtotal`。

建议在 Database Overview 加一句：

```md
The seed data currently includes 30 menu items across four categories, allowing the menu and homepage sections to display richer featured and popular choices.
```

### 2.5 Page Descriptions

需要逐页改：

| 页面 | 旧报告描述问题 | 当前应改成 |
|---|---|---|
| Homepage | 旧图和旧文案是 `Fresh meals ready for campus delivery`，普通 Featured/Popular food card | 当前是 `MellowBite - Premium Dining`，hero 为 premium dining，Featured Dishes 保持 food card，Popular Choices 使用 `.promo-card`，新增 Featured Specials/Chef Recommendations，两侧 specials panel |
| Menu Page | 旧图只显示 6 个菜品，旧浅色 UI | 当前 seed 有 30 个菜品；菜单仍支持 category filter、Details、Add to Cart，但 UI 是深色黑金 |
| Food Detail Page | 旧截图品牌/footer/UI 不一致 | 当前仍显示 image/category/description/ingredients/nutrition/price/rating/review_count/quantity/add-ons，但视觉要重截 |
| Registration Page | 旧品牌/footer/UI 不一致 | 字段和校验基本一致，但当前品牌为 MellowBite，auth panel 使用当前深色主题和 auth photo |
| Login Page | 旧品牌/footer/UI 不一致 | 逻辑基本一致；保留 demo admin/user 文案，但截图要更新 |
| Cart Page | 旧品牌/footer/UI 不一致 | 表格字段仍是 Item/Add-ons/Unit Price/Quantity/Subtotal/Action；需要重截当前主题 |
| Checkout Page | 旧品牌/footer/UI 不一致 | 表单字段仍是 delivery address/contact phone/payment method；需要重截当前主题 |
| Order Confirmation Page | 报告称 Order Confirmation Page，截图为 `Order success` | 当前 checkout 成功实际 forward 到 `orderSuccess.jsp`；报告应写 `Order Success / Order Confirmation Page`，并说明由 `CheckoutServlet` forward 到 `orderSuccess.jsp` |
| Order History Page | 旧品牌/footer/UI 不一致 | 表格字段仍是 Order ID/Items/Total/Time/Status；需要重截当前主题 |
| Admin Dashboard | 旧截图显示 Food Items=6 | 当前 seed 默认应显示 Food Items=30、Categories=4、Orders 取决于数据库订单数；截图必须重截 |
| Admin Food Management | 旧图没有 `Food Image` upload，没有 `Edit`/`Delete` 操作 | 当前表单有 `Food Image` file input；列表 Action 只有 `Edit`、`Delete`，加上表单的 Add/Save |
| Admin Category Management | 旧图只有 Add + Disable | 当前已改为 Add/Edit/Delete；截图必须重截 |
| Admin Order Management | 旧图品牌/UI 不一致 | 逻辑仍是 Complete/Cancel；截图重截即可 |
| About Page | 报告只说 homepage basic info | 当前有独立 about page：hero、stats、story、mission/vision、value grid、timeline、CTA；报告应新增/扩写 |
| FAQ Page | 报告只说 basic FAQ | 当前有 FAQ hero、search visual、tabs、accordion、help card；报告应新增/扩写 |
| Contact Page | 报告只说 Contact | 当前有 contact hero、info cards、message form、business hours、map preview、social cards、FAQ CTA；报告应新增/扩写 |

## 3. 图片和图注需要修改

报告中的 `Figure 4.x` 页面截图全部来自旧 UI，必须重截。当前 docx 图片映射如下：

| Figure | 报告图片文件 | 当前问题 | 修改要求 |
|---|---|---|---|
| Figure 2.1 System architecture | `image1.png` | 架构大体可用，但未体现 `StaticPageServlet` 当前没有 promotions、AdminFood 上传/删除、JS reveal/contact submit | 建议更新架构图，加入 Multipart upload、WebUtil validation/access control、JS interactions |
| Figure 2.2 Order processing flow | `image2.png` | 需要体现 Add to Cart 时就 requireLogin；菜单 quick add 与 detail add-ons 分流 | 更新流程图 |
| Figure 2.3 Admin management flow | `image3.png` | 缺少 Food Edit、Food Image Upload、Permanent Delete | 更新流程图 |
| Figure 3.1 ERD | `image4.png` | ERD 与当前 schema 基本一致 | 可保留；若重画，保持 `completed_time`、`featured`、`popular`、`addon_price` |
| Figure 4.1 Homepage | `image5.png` | 旧品牌 `Food Ordering`、旧 hero、旧浅色 UI、旧 Popular layout | 必须重截当前 homepage |
| Figure 4.2 Menu Page | `image6.png` | 旧品牌、旧浅色 UI、只展示 6 个菜品 | 必须重截当前 menu page |
| Figure 4.3 Food Detail Page | `image7.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 detail page |
| Figure 4.4 Registration Page | `image8.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 register page |
| Figure 4.5 Login Page | `image9.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 login page |
| Figure 4.6 Cart Page | `image10.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 cart page |
| Figure 4.7 Checkout Page | `image11.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 checkout page |
| Figure 4.8 Order Confirmation Page | `image12.png` | 旧品牌、旧 footer、流程页面名应写 `orderSuccess.jsp` | 必须重截当前 order success page；图注建议改为 `Order Success Page` |
| Figure 4.9 Order History Page | `image13.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 order history page |
| Figure 4.10 Admin Dashboard | `image14.png` | 旧品牌、Food Items=6 与当前 seed 不符 | 必须重截；默认 food count 应为 30 |
| Figure 4.11 Admin Food Management | `image15.png` | 缺少当前 `Food Image` upload、`Edit`、`Delete` 操作 | 必须重截当前 admin foods page |
| Figure 4.12 Admin Category Management | `image16.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 admin categories page |
| Figure 4.13 Admin Order Management | `image17.png` | 旧品牌、旧 footer、旧样式 | 必须重截当前 admin orders page |

还需要新增截图：
- About Page 当前独立页面。
- FAQ Page 当前独立页面。
- Contact Page 当前独立页面。
- Homepage 的 `Featured Specials / Chef's Recommendations` 区块。
- Popular Choices 使用 promotion card 样式后的区块特写。

## 4. 表格需要修改

### 4.1 Table 2.1 Role - Layer Table

旧表格不是错，但不完整。建议改为：

| Layer | 当前 Implementation | 需要体现的 Role |
|---|---|---|
| Front-end | JSP, HTML, CSS, JavaScript | 深色响应式页面、promotion-style Popular Choices、表单校验、reveal animation、contact fake submit |
| Controller | HomeServlet, MenuServlet, FoodDetailServlet, CartServlet, CheckoutServlet, LoginServlet, RegisterServlet, StaticPageServlet, AdminFoodServlet, AdminCategoryServlet, AdminOrderServlet | 路由、校验、登录/管理员权限、cart/order 状态变更、图片上传、add/edit/delete |
| Model | User, Food, Category, Cart, CartItem, Order, OrderItem | 应用数据对象和业务状态 |
| Data layer | MySQL, DAO classes, AppStore facade | 持久化 users/categories/foods/orders/order_items，加载 featured/popular foods |
| Authentication | HttpSession currentUser, WebUtil.requireLogin, WebUtil.requireAdmin | 控制客户下单和管理员访问 |
| Client Interactions | `assets/js/app.js` | required fields、quantity validation、contact alert/reset、IntersectionObserver reveal |

### 4.2 Table 3.1 Database Description Tables

需要小改：
- `users` 描述中把 `password` 改成 `hashed password`。
- `foods` 描述中保留 `featured`、`popular`，补充当前 seed 30 items。
- `orders` 描述中明确 `completed_time`。
- `order_items` 描述保持快照字段说明。

### 4.3 Table 5.1 Technology - Contribution Table

旧表缺少当前新增技术点。建议新增行：

| Technology | Where It Is Used | Contribution |
|---|---|---|
| DAO + JDBC | UserDao, FoodDao, CategoryDao, OrderDao | Encapsulates MySQL CRUD and query operations |
| MultipartConfig / Part | AdminFoodServlet | Supports uploaded food images |
| JavaScript IntersectionObserver | assets/js/app.js | Adds scroll reveal animation to `.reveal` sections |
| WebUtil | WebUtil.java | Shared forwarding, redirects, login/admin checks, cart creation, request parsing, add-on price calculation |
| PasswordUtil | Login/Register flow | Stores and checks hashed passwords |

### 4.4 页面表格截图内容

以下页面中的表格截图必须更新：
- Cart table：视觉更新，字段基本保留。
- Order History table：视觉更新，字段基本保留。
- Admin Food List：Action 现在只有 `Edit`、`Delete`；新增 food 由上方表单完成。
- Admin Category List：Action 现在只有 `Edit`、`Delete`；新增 category 由上方表单完成。
- Admin Orders table：视觉更新，字段基本保留。
- Admin Dashboard stats：Food Items 数量从旧截图 6 改为当前 seed 30，Orders 数量按实际数据库状态变化。

## 5. 交互逻辑修改清单

| 模块 | 旧报告描述 | 当前实际逻辑 | 报告应如何改 |
|---|---|---|---|
| Menu Add to Cart | 用户选择 items 后进入 cart/checkout 才检查 login | `CartServlet.doPost()` 先 `requireLogin`，未登录直接 `/login` | 写明 add-to-cart action requires login |
| Menu quick add | 报告未区分 quick add 和 detail add | 菜单页 quick add 使用 hidden `quantity=1`，无 add-ons | 补充说明 |
| Food detail add-ons | 报告正确提到 add-ons | 当前 add-ons 为 Extra Cheese/Drink/Large Portion，并通过 `WebUtil.addonPrice()` 计价 | 保留并写清价格 |
| Checkout success | 报告叫 Order Confirmation Page | 当前 `CheckoutServlet` forward 到 `orderSuccess.jsp` | 图注和文字改为 `Order Success / Order Confirmation` |
| Contact form | 报告未说明 | 前端 `fakeContactSubmit()`，不入库、不发邮件 | Contact Page 描述要写 simulated/front-end feedback |
| Reveal animation | 报告未说明 | `IntersectionObserver` 为 `.reveal` 元素加 `is-visible` | 在前端技术表或 UI 说明中补充 |
| Admin food add/update | 报告说 add/update/disable | 当前只有 add/edit/delete，并支持 edit mode、file upload、delete | 补充 `Food Image` upload 和 permanent delete |
| Admin delete food | 报告未说明 | `AdminRemoveFoodServlet` action delete；若有订单引用则失败并提示无法删除 | 加入 admin flow |
| Admin category management | 报告说 add/disable | 当前只有 add/edit/delete；分类被 food 引用时不能删除 | 更新 admin flow 和页面说明 |
| Promotions page | 旧项目有 promotions 页面 | 当前已删除 | 不要在报告里保留 promotions 页面或 `/promotions` 路由 |
| Static pages | 报告只泛泛说 About/FAQ/Contact | 当前 `StaticPageServlet` 只服务 `/about`、`/faq`、`/contact` | 写清静态页路由 |

## 6. 需要替换的旧文字示例

| 旧文字 | 新文字建议 |
|---|---|
| Food Ordering | MellowBite |
| Food Ordering System | MellowBite Food Ordering System |
| Fresh meals ready for campus delivery | Elegant restaurant favorites, ordered with ease |
| Campus meals, clear food details... | Premium dining favorites, generous photography, simple cart control, and a calm checkout flow |
| XMUM Campus Restaurant | MellowBite Restaurant |
| support@foodordering.test | support@mellowbite.test |
| Popular food items are displayed as compact food cards | Popular Choices are displayed using promotion-style cards with image, badge, category badge, description, price, rating, and details link |
| Admins can add, update, or disable food items | Admins can add, edit, upload food images, or permanently delete food items |

## 7. 建议的报告结构调整

建议在 Page Descriptions 中加入或扩展这些小节：

1. Homepage
2. Menu Page
3. Food Detail Page
4. Login Page
5. Registration Page
6. Cart Page
7. Checkout Page
8. Order Success Page
9. Order History Page
10. About Page
11. FAQ Page
12. Contact Page
13. Admin Dashboard
14. Admin Food Management Page
15. Admin Category Management Page
16. Admin Order Management Page

## 8. 最终更新优先级

必须优先改：
1. 全部截图，因为旧截图全部显示旧品牌和旧 UI。
2. 全文品牌名和 footer/contact 信息。
3. Homepage 说明：Popular Choices 使用 promotion card 样式，Featured Specials/Chef Recommendations 已存在。
4. Admin Food Management 和 Category Management 说明：只有 add/edit/delete，不再写 disable。
5. seed 数据说明：foods 当前为 30 个。
6. 删除任何 `/promotions` 或 `promotions.jsp` 相关描述。

可以保留但建议微调：
1. MVC 架构说明。
2. ERD 图。
3. 数据库五张表的总体说明。
4. 登录、注册、cart、checkout、order history 的核心业务描述。
