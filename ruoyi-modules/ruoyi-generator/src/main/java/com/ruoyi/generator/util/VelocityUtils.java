package com.ruoyi.generator.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import cn.hutool.core.collection.CollUtil;
import com.ruoyi.common.orm.helper.DataBaseHelper;
import org.apache.velocity.VelocityContext;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.constant.GenConstants;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.generator.domain.GenTable;
import com.ruoyi.generator.domain.GenTableColumn;

/**
 * 模板处理工具类
 *
 * @author ruoyi
 * @author 数据小王子
 */
public class VelocityUtils {
    /**
     * 项目空间路径
     */
    private static final String PROJECT_PATH = "main/java";

    /**
     * mybatis空间路径
     */
    private static final String MYBATIS_PATH = "main/resources/mapper";

    /**
     * 默认上级菜单，系统工具
     */
    private static final String DEFAULT_PARENT_MENU_ID = "3";

    /**
     * 设置模板变量信息
     *
     * @return 模板列表
     */
    public static VelocityContext prepareContext(GenTable genTable) {
        String moduleName = genTable.getModuleName();
        String businessName = genTable.getBusinessName();
        String packageName = genTable.getPackageName();
        String tplCategory = genTable.getTplCategory();
        String functionName = genTable.getFunctionName();

        VelocityContext velocityContext = new VelocityContext();
        velocityContext.put("tplCategory", genTable.getTplCategory());
        velocityContext.put("tableName", genTable.getTableName());
        velocityContext.put("CapitalUnderScoreClassName", StringUtils.upperCase(StringUtils.toUnderScoreCase(genTable.getClassName())));//大写的类名下划线：SYS_USER
        velocityContext.put("functionName", StringUtils.isNotEmpty(functionName) ? functionName : "【请填写功能名称】");
        velocityContext.put("ClassName", genTable.getClassName());
        velocityContext.put("className", StringUtils.uncapitalize(genTable.getClassName()));
        velocityContext.put("moduleName", genTable.getModuleName());
        velocityContext.put("BusinessName", StringUtils.capitalize(genTable.getBusinessName()));
        velocityContext.put("businessName", genTable.getBusinessName());
        velocityContext.put("basePackage", getPackagePrefix(packageName));
        velocityContext.put("packageName", packageName);
        velocityContext.put("author", genTable.getFunctionAuthor());
        velocityContext.put("datetime", DateUtils.getDate());
        velocityContext.put("pkColumn", genTable.getPkColumn());
        velocityContext.put("importList", getImportList(genTable));
        velocityContext.put("permissionPrefix", getPermissionPrefix(moduleName, businessName));
        velocityContext.put("columns", genTable.getColumns());
        velocityContext.put("table", genTable);
        velocityContext.put("dicts", getDicts(genTable));
        /* 编辑页列数*/
        velocityContext.put("editColumns", genTable.getEditColumns());
        setMenuVelocityContext(velocityContext, genTable);
        if (GenConstants.TPL_TREE.equals(tplCategory)) {
            setTreeVelocityContext(velocityContext, genTable);
        }
        if (GenConstants.TPL_SUB.equals(tplCategory)) {
            setSubVelocityContext(velocityContext, genTable);
        }
        return velocityContext;
    }

    public static void setMenuVelocityContext(VelocityContext context, GenTable genTable) {
        String options = genTable.getOptions();
        JSONObject paramsObj = JSON.parseObject(options);
        String parentMenuId = getParentMenuId(paramsObj);
        context.put("parentMenuId", parentMenuId);
    }

    public static void setTreeVelocityContext(VelocityContext context, GenTable genTable) {
        String options = genTable.getOptions();
        JSONObject paramsObj = JSON.parseObject(options);
        String treeCode = getTreecode(paramsObj);
        String treeParentCode = getTreeParentCode(paramsObj);
        String treeName = getTreeName(paramsObj);

        context.put("treeCode", treeCode);
        context.put("treeParentCode", treeParentCode);
        context.put("treeName", treeName);
        context.put("expandColumn", getExpandColumn(genTable));
        if (paramsObj.containsKey(GenConstants.TREE_PARENT_CODE)) {
            context.put("tree_parent_code", paramsObj.getString(GenConstants.TREE_PARENT_CODE));
        }
        if (paramsObj.containsKey(GenConstants.TREE_NAME)) {
            context.put("tree_name", paramsObj.getString(GenConstants.TREE_NAME));
        }
    }

    public static void setSubVelocityContext(VelocityContext context, GenTable genTable) {
        GenTable subTable = genTable.getSubTable();
        String subTableName = genTable.getSubTableName();
        String subTableFkName = genTable.getSubTableFkName();
        String subClassName = genTable.getSubTable().getClassName();
        String subTableFkClassName = StringUtils.convertToCamelCase(subTableFkName);

        context.put("subTable", subTable);
        context.put("subTableName", subTableName);
        context.put("subTableFkName", subTableFkName);
        context.put("subTableFkClassName", subTableFkClassName);
        context.put("CapitalUnderScoreSubTableFkClassName", StringUtils.upperCase(StringUtils.toUnderScoreCase(subTableFkClassName)));//带下划线的字段大写
        context.put("subTableFkclassName", StringUtils.uncapitalize(subTableFkClassName));
        context.put("subClassName", subClassName);
        context.put("CapitalUnderScoreSubClassName", StringUtils.upperCase(StringUtils.toUnderScoreCase(subClassName)));//大写的子类类名下划线：SYS_USER
        context.put("subclassName", StringUtils.uncapitalize(subClassName));
        context.put("subImportList", getImportList(genTable.getSubTable()));
    }

    /**
     * 获取模板信息
     *
     * @param tplCategory 单表、树表、主子表
     * @param frontType   前端界面类型取值：0是element-js、1是element-ts、2是antdesign-ts
     * @return 模板列表
     */
    public static List<String> getTemplateList(String tplCategory, Integer frontType) {
        List<String> templates = new ArrayList<>();
        templates.add("vm/java/domain.java.vm");
        templates.add("vm/java/vo.java.vm");
        templates.add("vm/java/vo-import.java.vm");
        templates.add("vm/java/bo.java.vm");
        templates.add("vm/java/mapper.java.vm");
        templates.add("vm/java/service.java.vm");
        templates.add("vm/java/serviceImpl.java.vm");
        templates.add("vm/java/controller.java.vm");
        templates.add("vm/java/listener.java.vm");
        templates.add("vm/xml/mapper.xml.vm");
        if (DataBaseHelper.isPostgreSql()) {
            templates.add("vm/sql/postgresql/sql.vm");
        } else {
            templates.add("vm/sql/mysql/sql.vm");
        }

        switch (frontType) {
            case 0 -> templates.add("vm/api/element.js.api.vm");
            case 1 -> {
                templates.add("vm/api/element.ts.api.vm");
                templates.add("vm/api/element.ts.types.vm");
            }
            case 2 -> {
                templates.add("vm/api/antdesign.ts.index.vm");
                templates.add("vm/api/antdesign.ts.model.vm");
            }
        }

        if (GenConstants.TPL_CRUD.equals(tplCategory)) {
            switch (frontType) {
                case 0 -> templates.add("vm/vue/element.js.index.vue.vm");
                case 1 -> templates.add("vm/vue/element.ts.index.vue.vm");
                case 2 -> {
                    templates.add("vm/vue/antdesign.ts.data.vm");
                    templates.add("vm/vue/antdesign.ts.index.vue.vm");
                    templates.add("vm/vue/antdesign.ts.modal.vue.vm");
                }
            }
        } else if (GenConstants.TPL_TREE.equals(tplCategory)) {
            switch (frontType) {
                case 0 -> templates.add("vm/vue/element.js.index-tree.vue.vm");
                case 1 -> templates.add("vm/vue/element.ts.index-tree.vue.vm");
                case 2 -> {
                    templates.add("vm/vue/antdesign.ts.data.vm");
                    templates.add("vm/vue/antdesign.ts.index.vue.vm");
                    templates.add("vm/vue/antdesign.ts.modal.vue.vm");
                }
            }

        } else if (GenConstants.TPL_SUB.equals(tplCategory)) {
            templates.add("vm/java/sub-domain.java.vm");
            templates.add("vm/java/sub-mapper.java.vm");
            templates.add("vm/xml/sub-mapper.xml.vm");
            switch (frontType) {
                case 0 -> templates.add("vm/vue/element.js.index.vue.vm");
                case 1 -> templates.add("vm/vue/element.ts.index.vue.vm");
                case 2 -> {
                    templates.add("vm/vue/antdesign.ts.data.vm");
                    templates.add("vm/vue/antdesign.ts.index.vue.vm");
                    templates.add("vm/vue/antdesign.ts.modal.vue.vm");
                }
            }
        }

        return templates;
    }

    /**
     * 获取文件名
     */
    public static String getFileName(String template, GenTable genTable) {
        // 文件名称
        String fileName = "";
        // 包路径
        String packageName = genTable.getPackageName();
        // 模块名
        String moduleName = genTable.getModuleName();
        // 大写类名
        String className = genTable.getClassName();
        // 业务名称
        String businessName = genTable.getBusinessName();

        String javaPath = PROJECT_PATH + "/" + StringUtils.replace(packageName, ".", "/");
        String mybatisPath = MYBATIS_PATH + "/" + moduleName;
        String vuePath = "vue";
        String vbenPath = "vben";
        String BusinessName = StringUtils.capitalize(genTable.getBusinessName());

        switch (template) {
            case "vm/java/domain.java.vm" -> fileName = StringUtils.format("{}/domain/{}.java", javaPath, className);
            case "vm/java/sub-domain.java.vm" ->
                fileName = StringUtils.format("{}/domain/{}.java", javaPath, genTable.getSubTable().getClassName());
            case "vm/java/vo.java.vm" -> fileName = StringUtils.format("{}/domain/vo/{}Vo.java", javaPath, className);
            case "vm/java/vo-import.java.vm" -> fileName = StringUtils.format("{}/domain/vo/{}ImportVo.java", javaPath, className);
            case "vm/java/bo.java.vm" -> fileName = StringUtils.format("{}/domain/bo/{}Bo.java", javaPath, className);
            case "vm/java/mapper.java.vm" ->
                fileName = StringUtils.format("{}/mapper/{}Mapper.java", javaPath, className);
            case "vm/java/sub-mapper.java.vm" ->
                fileName = StringUtils.format("{}/mapper/{}Mapper.java", javaPath, genTable.getSubTable().getClassName());
            case "vm/java/service.java.vm" ->
                fileName = StringUtils.format("{}/service/I{}Service.java", javaPath, className);
            case "vm/java/serviceImpl.java.vm" ->
                fileName = StringUtils.format("{}/service/impl/{}ServiceImpl.java", javaPath, className);
            case "vm/java/controller.java.vm" ->
                fileName = StringUtils.format("{}/controller/{}Controller.java", javaPath, className);
            case "vm/java/listener.java.vm" ->
                fileName = StringUtils.format("{}/listener/{}ImportListener.java", javaPath, className);
            case "vm/xml/mapper.xml.vm" -> fileName = StringUtils.format("{}/{}Mapper.xml", mybatisPath, className);
            case "vm/xml/sub-mapper.xml.vm" ->
                fileName = StringUtils.format("{}/{}Mapper.xml", mybatisPath, genTable.getSubTable().getClassName());
            case "vm/sql/postgresql/sql.vm" -> fileName = businessName + "Menu(postgresql).sql";
            case "vm/sql/mysql/sql.vm" -> fileName = businessName + "Menu(mysql).sql";
            case "vm/api/element.js.api.vm" ->
                fileName = StringUtils.format("{}/api/{}/{}.js", vuePath, moduleName, businessName);
            case "vm/api/element.ts.api.vm" ->
                fileName = StringUtils.format("{}/api/{}/{}/index.ts", vuePath, moduleName, businessName);
            case "vm/api/element.ts.types.vm" ->
                fileName = StringUtils.format("{}/api/{}/{}/types.ts", vuePath, moduleName, businessName);
            case "vm/api/antdesign.ts.index.vm" ->
                fileName = StringUtils.format("{}/api/{}/{}/index.ts", vbenPath, moduleName, businessName);
            case "vm/api/antdesign.ts.model.vm" ->
                fileName = StringUtils.format("{}/api/{}/{}/model.ts", vbenPath, moduleName, businessName);
            case "vm/vue/element.js.index.vue.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/index.vue", vuePath, moduleName, businessName);
            case "vm/vue/element.js.index-tree.vue.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/index.vue", vuePath, moduleName, businessName);
            case "vm/vue/element.ts.index.vue.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/index.vue", vuePath, moduleName, businessName);
            case "vm/vue/element.ts.index-tree.vue.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/index.vue", vuePath, moduleName, businessName);
            case "vm/vue/antdesign.ts.index.vue.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/index.vue", vbenPath, moduleName, businessName);
            case "vm/vue/antdesign.ts.data.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/{}.data.ts", vbenPath, moduleName, businessName, businessName);
            case "vm/vue/antdesign.ts.modal.vue.vm" ->
                fileName = StringUtils.format("{}/views/{}/{}/{}Modal.vue", vbenPath, moduleName, businessName, BusinessName);
            default -> fileName = "default.xml";
        }

        return fileName;
    }

    /**
     * 获取包前缀
     *
     * @param packageName 包名称
     * @return 包前缀名称
     */
    public static String getPackagePrefix(String packageName) {
        int lastIndex = packageName.lastIndexOf(".");
        return StringUtils.substring(packageName, 0, lastIndex);
    }

    /**
     * 根据列类型获取导入包
     *
     * @param genTable 业务表对象
     * @return 返回需要导入的包列表
     */
    public static HashSet<String> getImportList(GenTable genTable) {
        List<GenTableColumn> columns = genTable.getColumns();
        GenTable subGenTable = genTable.getSubTable();
        HashSet<String> importList = new HashSet<>();
        if (StringUtils.isNotNull(subGenTable)) {
            importList.add("java.util.List");
        }
        for (GenTableColumn column : columns) {
            if (!column.isSuperColumn() && GenConstants.TYPE_DATE.equals(column.getJavaType())) {
                importList.add("java.util.Date");
                importList.add("com.fasterxml.jackson.annotation.JsonFormat");
            } else if (!column.isSuperColumn() && GenConstants.TYPE_BIGDECIMAL.equals(column.getJavaType())) {
                importList.add("java.math.BigDecimal");
            }
        }
        return importList;
    }

    /**
     * 根据列类型获取字典组
     *
     * @param genTable 业务表对象
     * @return 返回字典组
     */
    public static String getDicts(GenTable genTable) {
        List<GenTableColumn> columns = genTable.getColumns();
        Set<String> dicts = new HashSet<>();
        addDicts(dicts, columns);
        if (StringUtils.isNotNull(genTable.getSubTable())) {
            List<GenTableColumn> subColumns = genTable.getSubTable().getColumns();
            addDicts(dicts, subColumns);
        }
        return StringUtils.join(dicts, ", ");
    }

    /**
     * 添加字典列表
     *
     * @param dicts   字典列表
     * @param columns 列集合
     */
    public static void addDicts(Set<String> dicts, List<GenTableColumn> columns) {
        for (GenTableColumn column : columns) {
            if (!column.isSuperColumn() && StringUtils.isNotEmpty(column.getDictType()) && StringUtils.equalsAny(
                column.getHtmlType(),
                new String[]{GenConstants.HTML_SELECT, GenConstants.HTML_RADIO, GenConstants.HTML_CHECKBOX})) {
                dicts.add("'" + column.getDictType() + "'");
            }
        }
    }

    /**
     * 获取权限前缀
     *
     * @param moduleName   模块名称
     * @param businessName 业务名称
     * @return 返回权限前缀
     */
    public static String getPermissionPrefix(String moduleName, String businessName) {
        return StringUtils.format("{}:{}", moduleName, businessName);
    }

    /**
     * 获取上级菜单ID字段
     *
     * @param paramsObj 生成其他选项
     * @return 上级菜单ID字段
     */
    public static String getParentMenuId(JSONObject paramsObj) {
        if (StringUtils.isNotEmpty(paramsObj) && paramsObj.containsKey(GenConstants.PARENT_MENU_ID)
            && StringUtils.isNotEmpty(paramsObj.getString(GenConstants.PARENT_MENU_ID))) {
            return paramsObj.getString(GenConstants.PARENT_MENU_ID);
        }
        return DEFAULT_PARENT_MENU_ID;
    }

    /**
     * 获取树编码
     *
     * @param paramsObj 生成其他选项
     * @return 树编码
     */
    public static String getTreecode(JSONObject paramsObj) {
        if (paramsObj.containsKey(GenConstants.TREE_CODE)) {
            return StringUtils.toCamelCase(paramsObj.getString(GenConstants.TREE_CODE));
        }
        return StringUtils.EMPTY;
    }

    /**
     * 获取树父编码
     *
     * @param paramsObj 生成其他选项
     * @return 树父编码
     */
    public static String getTreeParentCode(JSONObject paramsObj) {
        if (CollUtil.isNotEmpty(paramsObj) && paramsObj.containsKey(GenConstants.TREE_PARENT_CODE)) {
            return StringUtils.toCamelCase(paramsObj.getString(GenConstants.TREE_PARENT_CODE));
        }
        return StringUtils.EMPTY;
    }

    /**
     * 获取树名称
     *
     * @param paramsObj 生成其他选项
     * @return 树名称
     */
    public static String getTreeName(JSONObject paramsObj) {
        if (CollUtil.isNotEmpty(paramsObj) && paramsObj.containsKey(GenConstants.TREE_NAME)) {
            return StringUtils.toCamelCase(paramsObj.getString(GenConstants.TREE_NAME));
        }
        return StringUtils.EMPTY;
    }

    /**
     * 获取需要在哪一列上面显示展开按钮
     *
     * @param genTable 业务表对象
     * @return 展开按钮列序号
     */
    public static int getExpandColumn(GenTable genTable) {
        String options = genTable.getOptions();
        JSONObject paramsObj = JSON.parseObject(options);
        String treeName = paramsObj.getString(GenConstants.TREE_NAME);
        int num = 0;
        for (GenTableColumn column : genTable.getColumns()) {
            if (column.isList()) {
                num++;
                String columnName = column.getColumnName();
                if (columnName.equals(treeName)) {
                    break;
                }
            }
        }
        return num;
    }
}
