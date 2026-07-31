const hexoInject = hexo.extend.injector;

const styleCode = `
<style>
/* 只处理块公式 display=true 的公式容器 */
mjx-container.MathJax[jax="SVG"][display="true"] {
  display: block !important;
  max-width: 100% !important;
  overflow-x: auto !important;
  overflow-y: hidden !important;
  padding: 6px 0;
}

/* 行内公式保持原样，禁止块展示、禁止滚动 */
mjx-container.MathJax[jax="SVG"]:not([display="true"]) {
  display: inline-block !important;
}

/* 兜底：限制内部svg基础宽度，防止无限扩张 */
mjx-container.MathJax[jax="SVG"][display="true"] > svg {
  min-width: unset;
}

/* 美化移动端横向滚动条（可选） */
mjx-container.MathJax[jax="SVG"][display="true"]::-webkit-scrollbar {
  height: 4px;
}
mjx-container.MathJax[jax="SVG"][display="true"]::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 3px;
}

.post-body {
  text-align: left !important;
}
</style>
`;

hexoInject.register('body_end', styleCode);