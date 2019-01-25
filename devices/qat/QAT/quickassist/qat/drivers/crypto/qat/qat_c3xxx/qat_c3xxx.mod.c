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
	{ 0x8a7f71a4, __VMLINUX_SYMBOL_STR(adf_check_slice_hang) },
	{ 0x402b8281, __VMLINUX_SYMBOL_STR(__request_module) },
	{ 0x98ab5c8d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x7578489a, __VMLINUX_SYMBOL_STR(adf_pf_enable_vf2pf_comms) },
	{ 0x9f13414d, __VMLINUX_SYMBOL_STR(debugfs_create_dir) },
	{ 0xc2f7c1b1, __VMLINUX_SYMBOL_STR(pci_read_config_byte) },
	{ 0x59d5a7f7, __VMLINUX_SYMBOL_STR(dma_set_mask) },
	{ 0x1c3e657e, __VMLINUX_SYMBOL_STR(pci_disable_device) },
	{ 0x77f4d55, __VMLINUX_SYMBOL_STR(adf_dev_init) },
	{ 0xc0a3d105, __VMLINUX_SYMBOL_STR(find_next_bit) },
	{ 0xcf73ce21, __VMLINUX_SYMBOL_STR(pci_release_regions) },
	{ 0xdd9db41c, __VMLINUX_SYMBOL_STR(adf_dev_stop) },
	{ 0x1f00a364, __VMLINUX_SYMBOL_STR(adf_devmgr_rm_dev) },
	{ 0x183455ce, __VMLINUX_SYMBOL_STR(adf_init_arb) },
	{ 0xa8a6ec69, __VMLINUX_SYMBOL_STR(adf_set_ssm_wdtimer) },
	{ 0xbe4a1520, __VMLINUX_SYMBOL_STR(pci_set_master) },
	{ 0x48663ea0, __VMLINUX_SYMBOL_STR(adf_dev_shutdown) },
	{ 0x63327c7, __VMLINUX_SYMBOL_STR(adf_disable_aer) },
	{ 0x1ab09b5e, __VMLINUX_SYMBOL_STR(adf_cfg_dev_add) },
	{ 0x127b8725, __VMLINUX_SYMBOL_STR(pci_iounmap) },
	{ 0xd795224, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xefd95517, __VMLINUX_SYMBOL_STR(adf_isr_resource_alloc) },
	{ 0x400674a9, __VMLINUX_SYMBOL_STR(adf_get_heartbeat_status) },
	{ 0xdb17fb2, __VMLINUX_SYMBOL_STR(adf_clock_debugfs_add) },
	{ 0x4c48a854, __VMLINUX_SYMBOL_STR(debugfs_remove) },
	{ 0x64f9899d, __VMLINUX_SYMBOL_STR(adf_dev_measure_clock) },
	{ 0x238daeae, __VMLINUX_SYMBOL_STR(adf_print_err_registers) },
	{ 0xf00e0708, __VMLINUX_SYMBOL_STR(adf_cfg_dev_remove) },
	{ 0xedc0d257, __VMLINUX_SYMBOL_STR(adf_disable_sriov) },
	{ 0xb3dee621, __VMLINUX_SYMBOL_STR(adf_reset_flr) },
	{ 0x94e753b1, __VMLINUX_SYMBOL_STR(adf_isr_resource_free) },
	{ 0x6412729a, __VMLINUX_SYMBOL_STR(adf_pf_disable_vf2pf_comms) },
	{ 0x51f0c32a, __VMLINUX_SYMBOL_STR(adf_devmgr_add_dev) },
	{ 0xcaa5fc93, __VMLINUX_SYMBOL_STR(adf_cfg_set_asym_rings_mask) },
	{ 0x15455c9c, __VMLINUX_SYMBOL_STR(pci_select_bars) },
	{ 0xb3ea49f2, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_node_trace) },
	{ 0xbfabcdb5, __VMLINUX_SYMBOL_STR(adf_dev_start) },
	{ 0xf0fdf6cb, __VMLINUX_SYMBOL_STR(__stack_chk_fail) },
	{ 0xbae83eef, __VMLINUX_SYMBOL_STR(adf_sriov_configure) },
	{ 0x4c8e6b3c, __VMLINUX_SYMBOL_STR(adf_enable_aer) },
	{ 0x685795f2, __VMLINUX_SYMBOL_STR(adf_send_admin_init) },
	{ 0x75b79af9, __VMLINUX_SYMBOL_STR(adf_init_admin_comms) },
	{ 0x2ea2c95c, __VMLINUX_SYMBOL_STR(__x86_indirect_thunk_rax) },
	{ 0xebfdcb96, __VMLINUX_SYMBOL_STR(pci_read_config_dword) },
	{ 0xe69ab469, __VMLINUX_SYMBOL_STR(qat_crypto_dev_config) },
	{ 0xbdfb6dbb, __VMLINUX_SYMBOL_STR(__fentry__) },
	{ 0x2cb61da5, __VMLINUX_SYMBOL_STR(pci_unregister_driver) },
	{ 0x82fc4f9e, __VMLINUX_SYMBOL_STR(adf_configure_iov_threads) },
	{ 0xf99d347e, __VMLINUX_SYMBOL_STR(node_states) },
	{ 0xef3a2c8e, __VMLINUX_SYMBOL_STR(adf_config_device) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0xc3fc2f, __VMLINUX_SYMBOL_STR(pci_request_regions) },
	{ 0x7a7f7d68, __VMLINUX_SYMBOL_STR(dma_supported) },
	{ 0x99487493, __VMLINUX_SYMBOL_STR(__pci_register_driver) },
	{ 0xb352177e, __VMLINUX_SYMBOL_STR(find_first_bit) },
	{ 0x4cbbd171, __VMLINUX_SYMBOL_STR(__bitmap_weight) },
	{ 0x43b38448, __VMLINUX_SYMBOL_STR(dev_warn) },
	{ 0x46a13ec4, __VMLINUX_SYMBOL_STR(adf_devmgr_pci_to_accel_dev) },
	{ 0x1d18e24b, __VMLINUX_SYMBOL_STR(adf_exit_admin_comms) },
	{ 0x28318305, __VMLINUX_SYMBOL_STR(snprintf) },
	{ 0x8055d058, __VMLINUX_SYMBOL_STR(pci_iomap) },
	{ 0x80fb7cc8, __VMLINUX_SYMBOL_STR(adf_exit_arb) },
	{ 0x46734db7, __VMLINUX_SYMBOL_STR(pci_enable_device) },
	{ 0x5f328eb8, __VMLINUX_SYMBOL_STR(adf_cfg_gen_dispatch_arbiter) },
	{ 0x53108e44, __VMLINUX_SYMBOL_STR(pci_save_state) },
	{ 0x17fbce60, __VMLINUX_SYMBOL_STR(sme_me_mask) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=intel_qat";

MODULE_ALIAS("pci:v00008086d000019E2sv*sd*bc*sc*i*");

MODULE_INFO(srcversion, "5E5ABA7CCA81A2EEEE008B7");
MODULE_INFO(rhelversion, "7.5");
#ifdef RETPOLINE
	MODULE_INFO(retpoline, "Y");
#endif
