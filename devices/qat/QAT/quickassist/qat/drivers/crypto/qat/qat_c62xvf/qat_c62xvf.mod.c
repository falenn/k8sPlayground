#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x28950ef1, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0x402b8281, __VMLINUX_SYMBOL_STR(__request_module) },
	{ 0x98ab5c8d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x9f13414d, __VMLINUX_SYMBOL_STR(debugfs_create_dir) },
	{ 0xc2f7c1b1, __VMLINUX_SYMBOL_STR(pci_read_config_byte) },
	{ 0x59d5a7f7, __VMLINUX_SYMBOL_STR(dma_set_mask) },
	{ 0x1c3e657e, __VMLINUX_SYMBOL_STR(pci_disable_device) },
	{ 0xb210f159, __VMLINUX_SYMBOL_STR(adf_vf2pf_init) },
	{ 0x77f4d55, __VMLINUX_SYMBOL_STR(adf_dev_init) },
	{ 0xc0a3d105, __VMLINUX_SYMBOL_STR(find_next_bit) },
	{ 0x90c0724b, __VMLINUX_SYMBOL_STR(adf_vf2pf_shutdown) },
	{ 0x6eaba10b, __VMLINUX_SYMBOL_STR(adf_enable_vf2pf_comms) },
	{ 0x2c063f87, __VMLINUX_SYMBOL_STR(adf_vf_isr_resource_free) },
	{ 0x45d9cfe4, __VMLINUX_SYMBOL_STR(adf_devmgr_update_class_index) },
	{ 0xcf73ce21, __VMLINUX_SYMBOL_STR(pci_release_regions) },
	{ 0xdd9db41c, __VMLINUX_SYMBOL_STR(adf_dev_stop) },
	{ 0x1f00a364, __VMLINUX_SYMBOL_STR(adf_devmgr_rm_dev) },
	{ 0x636c619f, __VMLINUX_SYMBOL_STR(debugfs_remove_recursive) },
	{ 0xf432dd3d, __VMLINUX_SYMBOL_STR(__init_waitqueue_head) },
	{ 0xbe4a1520, __VMLINUX_SYMBOL_STR(pci_set_master) },
	{ 0x48663ea0, __VMLINUX_SYMBOL_STR(adf_dev_shutdown) },
	{ 0x1ab09b5e, __VMLINUX_SYMBOL_STR(adf_cfg_dev_add) },
	{ 0x127b8725, __VMLINUX_SYMBOL_STR(pci_iounmap) },
	{ 0xd795224, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x4c48a854, __VMLINUX_SYMBOL_STR(debugfs_remove) },
	{ 0xf00e0708, __VMLINUX_SYMBOL_STR(adf_cfg_dev_remove) },
	{ 0xdf7af69d, __VMLINUX_SYMBOL_STR(adf_pfvf_debugfs_add) },
	{ 0x51f0c32a, __VMLINUX_SYMBOL_STR(adf_devmgr_add_dev) },
	{ 0xcaa5fc93, __VMLINUX_SYMBOL_STR(adf_cfg_set_asym_rings_mask) },
	{ 0x15455c9c, __VMLINUX_SYMBOL_STR(pci_select_bars) },
	{ 0xb3ea49f2, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_node_trace) },
	{ 0xe30102a1, __VMLINUX_SYMBOL_STR(adf_disable_vf2pf_comms) },
	{ 0xbfabcdb5, __VMLINUX_SYMBOL_STR(adf_dev_start) },
	{ 0xf0fdf6cb, __VMLINUX_SYMBOL_STR(__stack_chk_fail) },
	{ 0x2ea2c95c, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_rax) },
	{ 0xebfdcb96, __VMLINUX_SYMBOL_STR(pci_read_config_dword) },
	{ 0xe69ab469, __VMLINUX_SYMBOL_STR(qat_crypto_dev_config) },
	{ 0xbdfb6dbb, __VMLINUX_SYMBOL_STR(__fentry__) },
	{ 0x2cb61da5, __VMLINUX_SYMBOL_STR(pci_unregister_driver) },
	{ 0xef3a2c8e, __VMLINUX_SYMBOL_STR(adf_config_device) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0xcc3b167a, __VMLINUX_SYMBOL_STR(adf_clean_vf_map) },
	{ 0xc3fc2f, __VMLINUX_SYMBOL_STR(pci_request_regions) },
	{ 0x7a7f7d68, __VMLINUX_SYMBOL_STR(dma_supported) },
	{ 0x99487493, __VMLINUX_SYMBOL_STR(__pci_register_driver) },
	{ 0xb352177e, __VMLINUX_SYMBOL_STR(find_first_bit) },
	{ 0x43b38448, __VMLINUX_SYMBOL_STR(dev_warn) },
	{ 0x46a13ec4, __VMLINUX_SYMBOL_STR(adf_devmgr_pci_to_accel_dev) },
	{ 0x28318305, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0x8055d058, __VMLINUX_SYMBOL_STR(pci_iomap) },
	{ 0x3c7051c4, __VMLINUX_SYMBOL_STR(adf_vf_isr_resource_alloc) },
	{ 0x46734db7, __VMLINUX_SYMBOL_STR(pci_enable_device) },
	{ 0x17fbce60, __VMLINUX_SYMBOL_STR(sme_me_mask) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=intel_qat";

MODULE_ALIAS("pci:v00008086d000037C9sv*sd*bc*sc*i*");

MODULE_INFO(srcversion, "C2044D4C95F2BA96F4F7637");
MODULE_INFO(rhelversion, "7.5");
#ifdef RETPOLINE
	MODULE_INFO(retpoline, "Y");
#endif
